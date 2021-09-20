import Foundation
import SwiftUI

struct Navigation: Decodable {
    struct Toolbar: Decodable {
        let leading: Component?
        let trailing: Component?
    }

    let title: String?
    let toolbar: Toolbar?
    let component: Component
}
