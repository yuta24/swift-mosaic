import Foundation

class Controller: ObservableObject {
    enum State {
        case loading
        case data(Data)
        case failed(Error)
    }

    @Published
    private(set) var state: State = .loading

    @Published
    private(set) var provider: Provider
    @Published
    var widgetID: WidgetID?

    init(_ provider: Provider) {
        self.provider = provider
    }

    func load() {
        switch provider {
        case .json(let json):
            if let data = json.data(using: .utf8) {
                state = .data(data)
            } else {
                state = .failed(NSError() as Error)
            }
        }
    }

    func dispatch(_ action: ButtonAction) {
        // FIXME: handle action
    }
}
