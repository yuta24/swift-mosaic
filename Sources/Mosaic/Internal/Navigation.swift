import Foundation
import SwiftUI

struct Navigation: Decodable {
    struct Toolbar: Decodable {
        let leading: UIComponent?
        let trailing: UIComponent?
    }

    let title: String?
    let toolbar: Toolbar?
    let component: UIComponent
}
