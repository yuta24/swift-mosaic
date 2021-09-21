import Foundation
import SwiftUI

extension Controller {
    func binding<V>(_ keyPath: ReferenceWritableKeyPath<Controller, V>) -> Binding<V> {
        return .init(
            get: { self[keyPath: keyPath] },
            set: { self[keyPath: keyPath] = $0 }
        )
    }
}
