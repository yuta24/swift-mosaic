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

struct Text: Decodable {
    let content: String
    let font: Font?
}

struct Button: Decodable {
    let label: Content
    let action: String?
}

enum Modifier: Decodable {
    // MARK: Colors and Patterns
    case foregroundColor(Color)
}

enum Content: View, Decodable {
    static var handler: (String) -> Void = { _ in }

    // MARK: Text

    case text(text: Text)

    // MARK: Images

    // MARK: Buttons

    indirect case button(button: Button)

    // MARK: Layout

    indirect case horizontal(alignment: VerticalAlignment, spacing: CGFloat?, contents: [Content])
    indirect case vertical(alignment: HorizontalAlignment, spacing: CGFloat?, contents: [Content])
    indirect case zaxis(alignment: Alignment, content: [Content])

    // MARK: Hierarchical Views

    indirect case navigation(title: String, contents: [Content])

    var body: some View {
        switch self {
        case .text(let text):
            return SwiftUI.Text(text.content)
                .font(text.font?.value)
                .eraseToAnyView()
        case .button(let button):
            return SwiftUI.Button(
                action: { if let action = button.action { Content.handler(action) } },
                label: { button.label }
            )
            .eraseToAnyView()
        case .horizontal(let alignment, let spacing, let contents):
            return HStack(
                alignment: alignment.value,
                spacing: spacing,
                content: { contents.views }
            )
            .eraseToAnyView()
        case .vertical(let alignment, let spacing, let contents):
            return VStack(
                alignment: alignment.value,
                spacing: spacing,
                content: { contents.views }
            )
            .eraseToAnyView()
        case .zaxis(let alignment, let contents):
            return ZStack(
                alignment: alignment.value,
                content: { contents.views }
            )
            .eraseToAnyView()
        case .navigation(let title, let contents):
            return NavigationView(content: {
                contents.views
                    .navigationTitle(title)
            })
            .eraseToAnyView()
        }
    }
}
