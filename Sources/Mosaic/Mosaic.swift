import Foundation
import SwiftUI

public protocol Sourceable {
    func toString() -> String
}

extension Int: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension UInt: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension Float: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension Double: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension CGFloat: Sourceable {
    public func toString() -> String {
        return "\(self)"
    }
}

extension String: Sourceable {
    public func toString() -> String {
        return self
    }
}

public enum Provider {
    case json(String, [String: Sourceable], (String, inout [String: Sourceable]) -> Void)
    case file(URL, [String: Sourceable], (String, inout [String: Sourceable]) -> Void)
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
        do {
            let json = try controller.body()
            if let data = json.data(using: .utf8) {
                let screen = try decoder.decode(Widget.self, from: data)
                return make(screen, with: controller)
                    .sheet(
                        item: .init(
                            get: { controller.widgetID },
                            set: { controller.widgetID = $0 }),
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
            } else {
                return EmptyView()
                    .eraseToAnyView()
            }
        } catch {
            print(error)
            return SwiftUI.Text("The JSON parsing failed.")
                .eraseToAnyView()
        }
    }

    public init(_ provider: Provider) {
        self._controller = .init(wrappedValue: .init(provider))
    }
}
