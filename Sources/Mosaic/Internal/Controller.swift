import Foundation

class Controller: ObservableObject {
    @Published
    private(set) var source: Source

    init(_ source: Source) {
        self.source = source
    }

    func body() throws -> String {
        switch source {
        case .json(var json, let dictionary, _):
            for (key, value) in dictionary {
                json = json.replacingOccurrences(of: key, with: "\(value)")
            }
            return json
        case .file(let url, let dictionary, _):
            var json = try String(contentsOf: url)
            for (key, value) in dictionary {
                json = json.replacingOccurrences(of: key, with: "\(value)")
            }
            return json
        }
    }

    func dispatch(_ action: String) {
        switch source {
        case .json(let string, var dictionary, let handler):
            handler(action, &dictionary)
            source = .json(string, dictionary, handler)
        case .file:
            break
        }
    }
}
