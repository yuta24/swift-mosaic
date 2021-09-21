import Foundation
import SwiftUI

public enum Provider {
    case json(String)
    case file(URL)
}

private let decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
}()

public struct MosaicView: View {
    @StateObject
    private var controller: Controller

    public var body: some View {
        switch controller.state {
        case .loading:
            return makeLoadingView().eraseToAnyView()
        case .data(let data):
            return makeDataView(data).eraseToAnyView()
        case .failed(let error):
            return makeFailedView(error).eraseToAnyView()
        }
    }

    public init(_ provider: Provider) {
        self._controller = .init(wrappedValue: .init(provider))
    }

    private func makeLoadingView() -> some View {
        return ProgressView()
            .onAppear {
                controller.load()
            }
    }

    private func makeDataView(_ data: Data) -> some View {
        do {
            let screen = try decoder.decode(Widget.self, from: data)
            return make(screen, with: controller)
                .sheet(
                    item: controller.binding(\.widgetID),
                    content: { id in
                        if let widget = screen.sheet?.widgets[id.rawValue] {
                            make(widget, with: controller)
                                .eraseToAnyView()
                        } else {
                            EmptyView().eraseToAnyView()
                        }
                    }
                )
                .eraseToAnyView()
        } catch {
            print(error)
            return SwiftUI.Text("The JSON parsing failed.")
                .eraseToAnyView()
        }
    }

    private func makeFailedView(_ error: Error) -> some View {
        return EmptyView()
    }
}
