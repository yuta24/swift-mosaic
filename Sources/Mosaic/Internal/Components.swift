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
}

enum VerticalAlignment: String, Decodable {
    case top
    case center
    case bottom
    case firstTextBaseline
    case lastTextBaseline
}

enum HorizontalAlignment: String, Decodable {
    case leading
    case center
    case trailing
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
}

struct AsyncImage: Decodable {
    let url: URL
}

enum ButtonAction: Decodable {
    case local(String)
    case remote
}

struct ToolbarItem: Decodable {
    let content: Component
}

struct NavigationLink: Decodable {
    enum Destination: Decodable {
        case json(component: Component)
    }

    let destination: Destination
    let label: Component
}

enum Component: Decodable {
    case text(title: String, modifiers: [Modifier]?)
    case image(systemName: String, resizable: Bool, modifiers: [Modifier]?)

    indirect case button(label: Component, action: ButtonAction?, modifiers: [Modifier]?)
    indirect case sheetButton(label: Component, id: WidgetID, modifiers: [Modifier]?)

    indirect case horizontal(alignment: VerticalAlignment, spacing: CGFloat?, components: [Component])
    indirect case vertical(alignment: HorizontalAlignment, spacing: CGFloat?, components: [Component])
    indirect case zaxis(alignment: Alignment, components: [Component])

    case spacer(modifiers: [Modifier]?)

    indirect case list(components: [Component])

    indirect case navigationLink(link: NavigationLink)
}
