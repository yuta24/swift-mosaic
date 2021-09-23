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

struct NavigationLink: Decodable {
    enum Destination: Decodable {
        case json(component: UIComponent)
        case ref(url: URL)
    }

    let destination: Destination
    let label: UIComponent
}

enum ButtonCommand: Decodable {
    case save(collection: String)
    case update(document: String, collection: String)
    case delete(document: String, collection: String)
}

enum UIComponent: Decodable {
    case text(title: String, modifiers: [Modifier]?)
    case edit(key: String, title: String, modifiers: [Modifier]?)
    case image(systemName: String, resizable: Bool, modifiers: [Modifier]?)
    case asyncImage(url: URL, resizable: Bool, modifiers: [Modifier]?)

    indirect case scoped(value: [String: String], component: UIComponent)

    indirect case submitButton(label: UIComponent, command: ButtonCommand?, modifiers: [Modifier]?)
    indirect case sheetButton(label: UIComponent, id: WidgetID, modifiers: [Modifier]?)

    indirect case horizontal(alignment: VerticalAlignment, spacing: CGFloat?, components: [UIComponent], modifiers: [Modifier]?)
    indirect case vertical(alignment: HorizontalAlignment, spacing: CGFloat?, components: [UIComponent], modifiers: [Modifier]?)
    indirect case zaxis(alignment: Alignment, components: [UIComponent], modifiers: [Modifier]?)

    case spacer(modifiers: [Modifier]?)

    indirect case scroll(components: [UIComponent])

    indirect case list(refreshable: Bool, components: [UIComponent])

    indirect case navigationLink(link: NavigationLink)
}
