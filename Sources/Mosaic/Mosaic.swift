import Foundation
import SwiftUI

public enum Source {
    case json(String, [String: Any], (String, inout [String: Any]) -> Void)
    case file(URL, [String: Any], (String, inout [String: Any]) -> Void)
}

public struct MosaicView: View {
    @StateObject
    private var controller: Controller

    public var body: some View {
        do {
            let json = try controller.body()
            if let data = json.data(using: .utf8) {
                return try JSONDecoder()
                    .decode(Content.self, from: data)
                    .toView(with: controller)
                    .eraseToAnyView()
            } else {
                return EmptyView()
                    .eraseToAnyView()
            }
        } catch {
            return EmptyView()
                .eraseToAnyView()
        }
    }

    public init(_ source: Source) {
        self._controller = .init(wrappedValue: .init(source))
    }
}
