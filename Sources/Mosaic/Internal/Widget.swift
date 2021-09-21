import Foundation
import SwiftUI

struct WidgetID: RawRepresentable {
    let rawValue: String
}

extension WidgetID: Identifiable {
    var id: WidgetID { self }
}

extension WidgetID: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(rawValue)
    }
}

extension WidgetID: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.rawValue = try container.decode(String.self)
    }
}

struct Sheet: Decodable {
    let widgets: [String: Widget]
}

struct Widget: Decodable {
    enum Content: Decodable {
        case navigation(navigation: Navigation)
        case component(component: UIComponent)
    }

    let content: Content
    let sheet: Sheet?
}
