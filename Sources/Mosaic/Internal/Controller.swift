import Foundation
import SwiftUI

class Controller: ObservableObject {
    enum State {
        case loading
        case data(Data)
        case failed(Error)
    }

    @Published
    var widgetID: WidgetID?

    @Published
    private(set) var state: State = .loading

    @Published
    private(set) var provider: Provider

    private let handler: (Command) -> Void

    init(_ provider: Provider, handler: @escaping (Command) -> Void) {
        self.provider = provider
        self.handler = handler
    }

    func load() async {
        switch provider {
        case .json(let json):
            if let data = json.data(using: .utf8) {
                state = .data(data)
            } else {
                state = .failed(NSError() as Error)
            }
        case .file(let url):
            do {
                let data = try Data(contentsOf: url)
                state = .data(data)
            } catch {
                state = .failed(error)
            }
        case .request(let request):
            var request = request

            do {
                if let token = try await Engine.provider() {
                    request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                }

                URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                    DispatchQueue.main.async { [weak self] in
                        if let error = error {
                            self?.state = .failed(error)
                            return
                        }

                        if let data = data {
                            self?.state = .data(data)
                        }
                    }
                }
                .resume()
            } catch {
                print(#file, #line, error)
            }
        }
    }

    func dispatch(_ command: ButtonCommand, _ data: [String: Any]) {
        print(#file, #line, data)
        switch command {
        case .save(let collection):
            handler(.save(data: data, collection: collection))
        case .update(let document, let collection):
            handler(.update(document: document, data: data, collection: collection))
        case .delete(let document, let collection):
            handler(.delete(document: document, collection: collection))
        }
    }
}

extension Controller {
    func binding<V>(_ keyPath: ReferenceWritableKeyPath<Controller, V>) -> Binding<V> {
        return .init(
            get: { self[keyPath: keyPath] },
            set: { self[keyPath: keyPath] = $0 }
        )
    }
}
