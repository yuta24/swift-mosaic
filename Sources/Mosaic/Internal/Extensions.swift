import Foundation
import SwiftUI

extension View {
    func eraseToAnyView() -> AnyView {
        return AnyView(self)
    }
}

extension Array where Element == Content {
    func toView(with controller: Controller) -> some View {
        switch count {
        case 0:
            return EmptyView()
                .eraseToAnyView()
        case 1:
            return ViewBuilder.buildBlock(self[0].toView(with: controller))
                .eraseToAnyView()
        case 2:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller))
                .eraseToAnyView()
        case 3:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller))
                .eraseToAnyView()
        case 4:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller), self[3].toView(with: controller))
                .eraseToAnyView()
        case 5:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller), self[3].toView(with: controller), self[4].toView(with: controller))
                .eraseToAnyView()
        case 6:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller), self[3].toView(with: controller), self[4].toView(with: controller), self[5].toView(with: controller))
                .eraseToAnyView()
        case 7:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller), self[3].toView(with: controller), self[4].toView(with: controller), self[5].toView(with: controller), self[6].toView(with: controller))
                .eraseToAnyView()
        case 8:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller), self[3].toView(with: controller), self[4].toView(with: controller), self[5].toView(with: controller), self[6].toView(with: controller), self[7].toView(with: controller))
                .eraseToAnyView()
        case 9:
            return ViewBuilder.buildBlock(self[0].toView(with: controller), self[1].toView(with: controller), self[2].toView(with: controller), self[3].toView(with: controller), self[4].toView(with: controller), self[5].toView(with: controller), self[6].toView(with: controller), self[7].toView(with: controller), self[8].toView(with: controller))
                .eraseToAnyView()
        default:
            return EmptyView()
                .eraseToAnyView()
        }
    }
}
