import Foundation
import SwiftUICore

extension Character {
    enum Detail {
        enum Constants {
            static let marvelUrl: URL = URL(string: "https://www.marvel.com/") ?? URL(fileURLWithPath: "")
            enum Series {
                static let width: CGFloat = 100.0
                static let height: CGFloat = width * 9 / 6
                static let padding: CGFloat = 15.0
                static let descriptionMaxLines: Int = 3
                static let cornerRadius: CGFloat = 4.0
                static let ratingImageSize: CGFloat = 30.0
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
