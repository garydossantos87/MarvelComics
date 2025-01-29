import Foundation
import SwiftUICore

extension Character {
    enum Detail {
        enum Constants {
            enum Series {
                static let width: CGFloat = 130.0
                static let height: CGFloat = width * 9 / 6
                static let verticalPadding: CGFloat = 25.0
                static let horizontalPadding: CGFloat = 25.0
            }
            enum Success {
                static let title = "Series"
                static let padding: CGFloat = 10.0
            }
            enum Header {
                static let heightPercentage: CGFloat = 0.35
                static let bottomPadding: CGFloat = 20.0
                static let titleFont = Font.system(size: 40.0, weight: .bold)
            }
        }
    }
}
