import Foundation
import SwiftUI

class ScopedValue: ObservableObject {
    @Published
    var value: [String: Any] {
        didSet {
            print(#file, #line, value)
        }
    }

    init(_ value: [String: Any] = [:]) {
        self.value = value
    }
}

struct Scoped<Content: View>: View {
    let build: () -> Content

    @StateObject
    private var value: ScopedValue

    var body: some View {
        build().environmentObject(value)
    }

    init(_ value: [String: Any], _ build: @escaping () -> Content) {
        self._value = .init(wrappedValue: .init(value))
        self.build = build
    }
}
