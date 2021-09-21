import Foundation
import SwiftUI

struct SubmitButton<Content: View>: View {
    let action: ([String: Any]) -> Void
    let label: () -> Content

    @EnvironmentObject
    private var value: ScopedValue
    @EnvironmentObject
    private var controller: Controller

    var body: some View {
        Button(
            action: {
                action(value.value)
                controller.widgetID = nil
            },
            label: label)
    }
}
