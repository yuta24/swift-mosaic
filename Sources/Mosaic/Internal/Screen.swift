import Foundation
import SwiftUI

private struct ScreenID: Identifiable {
    let id: String
}

private class ScreenViewModel<Item: Identifiable>: ObservableObject {
    @Published
    var item: Item?
}

private struct ScreenView<Content: View, Item: Identifiable>: View {
    let content: Content
    let controller: Controller
    let build: (Item) -> AnyView

    @StateObject
    var viewModel: ScreenViewModel<Item>

    var body: some View {
        content.sheet(
            item: .init(get: { viewModel.item }, set: { viewModel.item = $0 }),
            content: build)
    }
}

struct Sheet: Decodable {
    let contents: [String: Content]
}

struct Screen: Decodable {
    let content: Content
    let sheet: Sheet?

    func toView(with controller: Controller) -> some View {
        let viewModel = ScreenViewModel<ScreenID>()
        let target = ScreenView(
            content: content.toView(with: controller),
            controller: controller,
            build: { (id: ScreenID) in
                return sheet?.contents[id.id]?
                    .toView(with: controller)
                    .eraseToAnyView()
                ?? EmptyView().eraseToAnyView()
            },
            viewModel: viewModel
        )

        controller.transitor = { action in
            viewModel.item = .init(id: action)
        }

        return target
    }
}
