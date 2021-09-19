import Foundation
import SwiftUI

enum Color: Decodable {
    case red
    case orange
    case yellow
    case green
    case mint
    case teal
    case cyan
    case blue
    case indigo
    case purple
    case pink
    case brown
    case white
    case gray
    case black
    case clear
    case primary
    case secondary

    var value: SwiftUI.Color {
        switch self {
        case .red:
            return .red
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .mint:
            return .mint
        case .teal:
            return .teal
        case .cyan:
            return .cyan
        case .blue:
            return .blue
        case .indigo:
            return .indigo
        case .purple:
            return .purple
        case .pink:
            return .pink
        case .brown:
            return .brown
        case .white:
            return .white
        case .gray:
            return .gray
        case .black:
            return .black
        case .clear:
            return .clear
        case .primary:
            return .primary
        case .secondary:
            return .secondary
        }
    }
}

enum Font: String, Decodable {
    case largeTitle
    case title
    case title2
    case title3
    case headline
    case subheadline
    case body
    case callout
    case footnote
    case caption
    case caption2

    var value: SwiftUI.Font {
        switch self {
        case .largeTitle:
            return .largeTitle
        case .title:
            return .title
        case .title2:
            return .title2
        case .title3:
            return .title3
        case .headline:
            return .headline
        case .subheadline:
            return .subheadline
        case .body:
            return .body
        case .callout:
            return .callout
        case .footnote:
            return .footnote
        case .caption:
            return .caption
        case .caption2:
            return .caption2
        }
    }
}

enum VerticalAlignment: String, Decodable {
    case top
    case center
    case bottom
    case firstTextBaseline
    case lastTextBaseline

    var value: SwiftUI.VerticalAlignment {
        switch self {
        case .top:
            return .top
        case .center:
            return .center
        case .bottom:
            return .bottom
        case .firstTextBaseline:
            return .firstTextBaseline
        case .lastTextBaseline:
            return .lastTextBaseline
        }
    }
}

enum HorizontalAlignment: String, Decodable {
    case leading
    case center
    case trailing

    var value: SwiftUI.HorizontalAlignment {
        switch self {
        case .leading:
            return .leading
        case .center:
            return .center
        case .trailing:
            return .trailing
        }
    }
}

enum Alignment: Decodable {
    case center
    case leading
    case trailing
    case top
    case bottom
    case topLeading
    case topTrailing
    case bottomLeading
    case bottomTrailing

    var value: SwiftUI.Alignment {
        switch self {
        case .center:
            return .center
        case .leading:
            return .leading
        case .trailing:
            return .trailing
        case .top:
            return .top
        case .bottom:
            return .bottom
        case .topLeading:
            return .topLeading
        case .topTrailing:
            return .topTrailing
        case .bottomLeading:
            return .bottomLeading
        case .bottomTrailing:
            return .bottomTrailing
        }
    }
}

enum ToolbarItemPlacement: String, Decodable {
    case automatic
    case principal
    case navigation
    case primaryAction
    case status
    case confirmationAction
    case cancellationAction
    case destructiveAction
    case keyboard
    case navigationBarLeading
    case navigationBarTrailing
    case bottomBar

    var value: SwiftUI.ToolbarItemPlacement {
        switch self {
        case .automatic:
            return .automatic
        case .principal:
            return .principal
        case .navigation:
            return .navigation
        case .primaryAction:
            return .primaryAction
        case .status:
            return .status
        case .confirmationAction:
            return .confirmationAction
        case .cancellationAction:
            return .cancellationAction
        case .destructiveAction:
            return .destructiveAction
        case .keyboard:
            return .keyboard
        case .navigationBarLeading:
            return .navigationBarLeading
        case .navigationBarTrailing:
            return .navigationBarTrailing
        case .bottomBar:
            return .bottomBar
        }
    }
}

struct Text: Decodable {
    let content: String
    let font: Font?
}

struct Image: Decodable {
    let systemName: String
}

struct AsyncImage: Decodable {
    let url: URL
}

enum Action: Decodable {
    case local(String)
    case remote
}

struct Button: Decodable {
    let label: Content
    let action: Action?
}

struct SheetButton: Decodable {
    let label: Content
    let action: String
}

struct ToolbarItem: Decodable {
    let content: Content
}

struct Toolbar: Decodable {
    let leading: ToolbarItem?
    let trailing: ToolbarItem?
}

struct NavigationLink: Decodable {
    let destination: Content
    let label: Content
}

enum Modifier: Decodable {
    // MARK: Colors and Patterns
    case foregroundColor(Color)
}

enum Content: Decodable {
    // MARK: Text

    case text(text: Text)

    // MARK: Images

    case image(image: Image)
    case asyncImage(image: AsyncImage)

    // MARK: Buttons

    indirect case button(button: Button)

    // MARK: Stacks

    indirect case horizontal(alignment: VerticalAlignment, spacing: CGFloat?, contents: [Content])
    indirect case vertical(alignment: HorizontalAlignment, spacing: CGFloat?, contents: [Content])
    indirect case zaxis(alignment: Alignment, content: [Content])

    // MARK: Lists

    indirect case list(contents: [Content])

    // MARK: Hierarchical Views

    indirect case navigation(title: String?, toolbar: Toolbar?, contents: [Content])
    indirect case navigationLink(link: NavigationLink)

    // MARK: Custom

    indirect case sheetButton(sheetButton: SheetButton)

    func toView(with controller: Controller) -> some View {
        switch self {
        case .text(let text):
            return SwiftUI.Text(text.content)
                .font(text.font?.value)
                .eraseToAnyView()
        case .image(let image):
            return SwiftUI.Image(systemName: image.systemName)
                .eraseToAnyView()
        case .asyncImage(let image):
            return SwiftUI.AsyncImage(url: image.url)
                .eraseToAnyView()
        case .button(let button):
            return SwiftUI.Button(
                action: { if let action = button.action { controller.dispatch(action) } },
                label: { button.label.toView(with: controller) })
            .eraseToAnyView()
        case .horizontal(let alignment, let spacing, let contents):
            return HStack(
                alignment: alignment.value,
                spacing: spacing,
                content: { contents.toView(with: controller) }
            )
            .eraseToAnyView()
        case .vertical(let alignment, let spacing, let contents):
            return VStack(
                alignment: alignment.value,
                spacing: spacing,
                content: { contents.toView(with: controller) }
            )
            .eraseToAnyView()
        case .zaxis(let alignment, let contents):
            return ZStack(
                alignment: alignment.value,
                content: { contents.toView(with: controller) }
            )
            .eraseToAnyView()
        case .list(let contents):
            return List {
                contents.toView(with: controller)
            }
            .eraseToAnyView()
        case .navigation(let title, let toolbar, let contents):
            var target = contents.toView(with: controller).eraseToAnyView()
            if let title = title {
                target = target.navigationTitle(title).eraseToAnyView()
            }
            if let toolbar = toolbar {
                if let item = toolbar.leading {
                    target = target.toolbar {
                        SwiftUI.ToolbarItem(placement: .navigationBarLeading) {
                            item.content.toView(with: controller)
                        }
                    }
                    .eraseToAnyView()
                }
                if let item = toolbar.trailing {
                    target = target.toolbar {
                        SwiftUI.ToolbarItem(placement: .navigationBarTrailing) {
                            item.content.toView(with: controller)
                        }
                    }
                    .eraseToAnyView()
                }
            }

            return NavigationView {
                target
            }
            .eraseToAnyView()
        case .navigationLink(let link):
            return SwiftUI.NavigationLink(
                destination: { LazyView(link.destination.toView(with: controller)) },
                label: { link.label.toView(with: controller) }
            )
            .eraseToAnyView()
        case .sheetButton(let sheetButton):
            return SwiftUI.Button(
                action: { controller.transit(sheetButton.action) },
                label: { sheetButton.label.toView(with: controller) }
            )
            .eraseToAnyView()
        }
    }
}
