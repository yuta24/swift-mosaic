import Foundation
import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

extension Array where Element == Content {
    var views: AnyView {
        switch count {
        case 0:
            return EmptyView()
                .eraseToAnyView()
        case 1:
            return ViewBuilder.buildBlock(self[0])
                .eraseToAnyView()
        case 2:
            return ViewBuilder.buildBlock(self[0], self[1])
                .eraseToAnyView()
        case 3:
            return ViewBuilder.buildBlock(self[0], self[1], self[2])
                .eraseToAnyView()
        case 4:
            return ViewBuilder.buildBlock(self[0], self[1], self[2], self[3])
                .eraseToAnyView()
        case 5:
            return ViewBuilder.buildBlock(self[0], self[1], self[2], self[3], self[4])
                .eraseToAnyView()
        case 6:
            return ViewBuilder.buildBlock(self[0], self[1], self[2], self[3], self[4], self[5])
                .eraseToAnyView()
        case 7:
            return ViewBuilder.buildBlock(self[0], self[1], self[2], self[3], self[4], self[5], self[6])
                .eraseToAnyView()
        case 8:
            return ViewBuilder.buildBlock(self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7])
                .eraseToAnyView()
        case 9:
            return ViewBuilder.buildBlock(self[0], self[1], self[2], self[3], self[4], self[5], self[6], self[7], self[8])
                .eraseToAnyView()
        default:
            return EmptyView()
                .eraseToAnyView()
        }
    }
}
