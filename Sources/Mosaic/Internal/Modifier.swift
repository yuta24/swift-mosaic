import Foundation
import SwiftUI

struct EdgeInsets: Decodable {
    let top: CGFloat
    let leading: CGFloat
    let bottom: CGFloat
    let trailing: CGFloat
}

enum ContentMode: String, Decodable {
    case fit
    case fill
}

enum Modifier: Decodable {
    case frame(width: CGFloat, height: CGFloat)
    case font(font: Font)
    case backgroundColor(color: Color)
    case foregroundColor(color: Color)
    case padding(insets: EdgeInsets)
    case aspectRatio(mode: ContentMode)
}

struct CustomModifier: ViewModifier {
    let modifier: Modifier

    init(_ modifier: Modifier) {
        self.modifier = modifier
    }

    func body(content: Content) -> some View {
        switch modifier {
        case .frame(let width, let height):
            content.frame(width: width, height: height)
        case .font(let font):
            content.font(make(font))
        case .backgroundColor(let color):
            content.background(make(color))
        case .foregroundColor(let color):
            content.foregroundColor(make(color))
        case .padding(let insets):
            content.padding(make(insets))
        case .aspectRatio(let mode):
            content.aspectRatio(contentMode: make(mode))
        }
    }
}

struct CustomModifiers: ViewModifier {
    let modifiers: [Modifier]

    init(_ modifiers: [Modifier]) {
        self.modifiers = modifiers
    }

    func body(content: Content) -> some View {
        var content: AnyView = content.eraseToAnyView()
        for modifier in modifiers {
            content = content.modifier(CustomModifier(modifier))
                .eraseToAnyView()
        }
        return content
    }
}
