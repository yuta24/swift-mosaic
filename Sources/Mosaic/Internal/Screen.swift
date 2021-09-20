import Foundation
import SwiftUI

struct ScreenID: RawRepresentable {
    let rawValue: String
}

extension ScreenID: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension ScreenID: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }
}

class ScreenViewModel: ObservableObject {
    @Published
    var id: ScreenID?
}

struct ScreenView<Content: View>: View {
    let content: Content
    let controller: Controller
    let build: (ScreenID) -> AnyView

    @StateObject
    var viewModel: ScreenViewModel

    var body: some View {
        content
//            .sheet(
//            item: .init(get: { viewModel.id }, set: { viewModel.id = $0 }),
//            content: build)
    }
}

struct Sheet: Decodable {
    let components: [ScreenID: Component]
}

struct Screen: Decodable {
    enum Content: Decodable {
        case navigation(navigation: Navigation)
        case component(component: Component)
    }

    let content: Content
    let sheet: Sheet?
}
