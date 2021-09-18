import Foundation
import SwiftUI

public enum Source {
    case json(String, [String: Any], (String, inout [String: Any]) -> [String: Any])
    case file(URL, [String: Any], (String, inout [String: Any]) -> [String: Any])
}

public class Engine: ObservableObject {
    @Published
    private(set) var source: Source

    init(_ source: Source) {
        self.source = source
    }

    func dispatch(_ action: String) {
        switch source {
        case .json(let string, var dictionary, let handler):
            let newDictionary = handler(action, &dictionary)
            source = .json(string, newDictionary, handler)
        case .file:
            break
        }
    }
}

public struct Configure {
    public let source: Source

    public init(source: Source) {
        self.source = source
    }
}

public enum Mosaic {
    public static func build(_ configure: Configure) -> Engine {
        return .init(configure.source)
    }
}

public struct Root: View {
    @ObservedObject
    private var engine: Engine

    public var body: some View {
        switch engine.source {
        case .json(let json, let dictionary, _):
            Content.handler = engine.dispatch
            var result = json
            for (key, value) in dictionary {
                result = result.replacingOccurrences(of: key, with: "\(value)")
            }
            do {
                if let data = result.data(using: .utf8) {
                    return try JSONDecoder()
                        .decode(Content.self, from: data)
                        .eraseToAnyView()
                } else {
                    return EmptyView()
                        .eraseToAnyView()
                }
            } catch {
                print(error.localizedDescription)
                return EmptyView()
                    .eraseToAnyView()
            }
        case .file(let url, let dictionary, _):
            Content.handler = engine.dispatch
            do {
                var result = try String(contentsOf: url)
                for (key, value) in dictionary {
                    result = result.replacingOccurrences(of: key, with: "\(value)")
                }
                if let data = result.data(using: .utf8) {
                    return try JSONDecoder()
                        .decode(Content.self, from: data)
                        .eraseToAnyView()
                } else {
                    return EmptyView()
                        .eraseToAnyView()
                }
            } catch {
                print(error.localizedDescription)
                return EmptyView()
                    .eraseToAnyView()
            }
        }
    }

    public init(_ engine: Engine) {
        self.engine = engine
    }
}
