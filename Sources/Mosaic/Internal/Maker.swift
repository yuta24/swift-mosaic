import Foundation
import SwiftUI

func make(_ color: Color) -> SwiftUI.Color {
    switch color {
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

func make(_ font: Font) -> SwiftUI.Font {
    switch font {
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

func make(_ alignment: VerticalAlignment) -> SwiftUI.VerticalAlignment {
    switch alignment {
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

func make(_ alignment: HorizontalAlignment) -> SwiftUI.HorizontalAlignment {
    switch alignment {
    case .leading:
        return .leading
    case .center:
        return .center
    case .trailing:
        return .trailing
    }
}

func make(_ alignment: Alignment) -> SwiftUI.Alignment {
    switch alignment {
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

func make(_ insets: EdgeInsets) -> SwiftUI.EdgeInsets {
    return .init(
        top: insets.top,
        leading: insets.leading,
        bottom: insets.bottom,
        trailing: insets.trailing)
}

func make(_ mode: ContentMode) -> SwiftUI.ContentMode {
    switch mode {
    case .fit:  return .fit
    case .fill: return .fill
    }
}

func make(_ components: [Component], with controller: Controller) -> some View {
    switch components.count {
    case 0:
        return EmptyView()
            .eraseToAnyView()
    case 1:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller)
        )
        .eraseToAnyView()
    case 2:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller)
        )
        .eraseToAnyView()
    case 3:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller)
        )
        .eraseToAnyView()
    case 4:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller),
            make(components[3], with: controller)
        )
        .eraseToAnyView()
    case 5:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller),
            make(components[3], with: controller),
            make(components[4], with: controller)
        )
        .eraseToAnyView()
    case 6:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller),
            make(components[3], with: controller),
            make(components[4], with: controller),
            make(components[5], with: controller)
        )
        .eraseToAnyView()
    case 7:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller),
            make(components[3], with: controller),
            make(components[4], with: controller),
            make(components[5], with: controller),
            make(components[6], with: controller)
        )
        .eraseToAnyView()
    case 8:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller),
            make(components[3], with: controller),
            make(components[4], with: controller),
            make(components[5], with: controller),
            make(components[6], with: controller),
            make(components[7], with: controller)
        )
        .eraseToAnyView()
    case 9:
        return ViewBuilder.buildBlock(
            make(components[0], with: controller),
            make(components[1], with: controller),
            make(components[2], with: controller),
            make(components[3], with: controller),
            make(components[4], with: controller),
            make(components[5], with: controller),
            make(components[6], with: controller),
            make(components[7], with: controller),
            make(components[8], with: controller)
        )
        .eraseToAnyView()
    default:
        return EmptyView()
            .eraseToAnyView()
    }
}

func make(_ component: Component, with controller: Controller) -> some View {
    switch component {
    case .text(let title, let modifiers):
        let modifiers = modifiers ?? []
        return SwiftUI.Text(title)
            .modifier(CustomModifiers(modifiers))
            .eraseToAnyView()
    case .image(let systemName, let resizable, let modifiers):
        let modifiers = modifiers ?? []
        if resizable {
            return SwiftUI.Image(systemName: systemName)
                .resizable()
                .modifier(CustomModifiers(modifiers))
                .eraseToAnyView()
        } else {
            return SwiftUI.Image(systemName: systemName)
                .eraseToAnyView()
        }
    case .button(let label, let action, let modifiers):
        let modifiers = modifiers ?? []
        return SwiftUI.Button(
            action: { if let action = action { controller.dispatch(action) } },
            label: { make(label, with: controller) }
        )
        .modifier(CustomModifiers(modifiers))
        .eraseToAnyView()
    case .sheetButton(let label, let id, let modifiers):
        let modifiers = modifiers ?? []
        return SwiftUI.Button(
            action: { controller.widgetID = id },
            label: { make(label, with: controller) }
        )
        .modifier(CustomModifiers(modifiers))
        .eraseToAnyView()
    case .horizontal(let alignment, let spacing, let contents):
        return HStack(
            alignment: make(alignment),
            spacing: spacing,
            content: { make(contents, with: controller) }
        )
        .eraseToAnyView()
    case .vertical(let alignment, let spacing, let contents):
        return VStack(
            alignment: make(alignment),
            spacing: spacing,
            content: { make(contents, with: controller) }
        )
        .eraseToAnyView()
    case .zaxis(let alignment, let contents):
        return ZStack(
            alignment: make(alignment),
            content: { make(contents, with: controller) }
        )
        .eraseToAnyView()
    case .spacer(let modifiers):
        let modifiers = modifiers ?? []
        return Spacer()
            .modifier(CustomModifiers(modifiers))
            .eraseToAnyView()
    case .list(let contents):
        return List {
            make(contents, with: controller)
        }
        .eraseToAnyView()
    case .navigationLink(let link):
        switch link.destination {
        case .json(let destination):
            return SwiftUI.NavigationLink(
                destination: { Lazy(make(destination, with: controller)) },
                label: { make(link.label, with: controller) }
            )
            .eraseToAnyView()
        }
    }
}

func make(_ navigation: Navigation, with controller: Controller) -> some View {
    var target = make(navigation.component, with: controller).eraseToAnyView()

    if let title = navigation.title {
        target = target.navigationTitle(title).eraseToAnyView()
    }

    if let leading = navigation.toolbar?.leading {
        target = target.toolbar {
            SwiftUI.ToolbarItem(placement: .navigationBarLeading) {
                make(leading, with: controller)
            }
        }
        .eraseToAnyView()
    }
    if let trailing = navigation.toolbar?.trailing {
        target = target.toolbar {
            SwiftUI.ToolbarItem(placement: .navigationBarTrailing) {
                make(trailing, with: controller)
            }
        }
        .eraseToAnyView()
    }

    return NavigationView {
        target
    }
}

func make(_ widget: Widget, with controller: Controller) -> some View {
    switch widget.content {
    case .navigation(let navigation):
        return make(navigation, with: controller).eraseToAnyView()
    case .component(let component):
        return make(component, with: controller).eraseToAnyView()
    }
}
