import Foundation

class Controller: ObservableObject {
    @Published
    private(set) var provider: Provider
    @Published
    var widgetID: WidgetID?

    init(_ provider: Provider) {
        self.provider = provider
    }

    func body() throws -> String {
        switch provider {
        case .json(var json, let dictionary, _):
            for (key, value) in dictionary {
                json = json.replacingOccurrences(of: key, with: value.toString())
            }
            return json
        case .file(let url, let dictionary, _):
            var json = try String(contentsOf: url)
            for (key, value) in dictionary {
                json = json.replacingOccurrences(of: key, with: value.toString())
            }
            return json
        }
    }

    func dispatch(_ action: ButtonAction) {
        switch action {
        case .local(let command):
            dispatchForLocal(command)
        case .remote:
            dispatchForRemote()
        }
    }

    private func dispatchForLocal(_ command: String) {
        switch provider {
        case .json(let string, var dictionary, let handler):
            handler(command, &dictionary)
            provider = .json(string, dictionary, handler)
        case .file(let string, var dictionary, let handler):
            handler(command, &dictionary)
            provider = .file(string, dictionary, handler)
        }
    }

    private func dispatchForRemote() {
        switch provider {
        case .json(_, _, _):
            break
        case .file(_, _, _):
            break
        }
    }
}
