import Foundation
import SwiftUI

struct TextFieldWrapper: View {
    let key: String
    let title: String

    @EnvironmentObject
    var value: ScopedValue

    var body: some View {
        SwiftUI.TextField(
            title,
            text: .init(
                get: { value.value[key] as? String ?? "" },
                set: { value.value[key] = $0 }
            )
        )
    }

    init(_ title: String, _ key: String) {
        self.key = key
        self.title = title
    }
}
