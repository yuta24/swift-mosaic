import Foundation
import SwiftUI

struct Lazy<Content: View>: View {
    let build: () -> Content

    var body: some View {
        build()
    }

    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
}
