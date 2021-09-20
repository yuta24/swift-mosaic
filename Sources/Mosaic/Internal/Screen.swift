import Foundation
import SwiftUI

struct ScreenID: RawRepresentable {
    let rawValue: String
}

extension ScreenID: Identifiable {
    var id: ScreenID { self }
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

struct Sheet: Decodable {
    let components: [String: Component]
}

struct Screen: Decodable {
    enum Content: Decodable {
        case navigation(navigation: Navigation)
        case component(component: Component)
    }

    let content: Content
    let sheet: Sheet?
}
