import Foundation
import SwiftUICore

extension Comic {
    enum Detail {

    }
}

extension Comic.Detail.MainView {
    enum Constants {
        static let navBarHeight: CGFloat = 100.0
        enum Header {
            static let linearGradient = LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            static let spacing: CGFloat = 8.0
            static let spacingTop: CGFloat = 10.0
            static let cartImage = Image(systemName: "cart.fill")
            static let cornerRadius: CGFloat = 12.0
            static func getHeight(with screenHeight: CGFloat) -> CGFloat {
                screenHeight * 0.40
            }
            static func getWidth(with screenWidth: CGFloat) -> CGFloat {
                screenWidth - 40
            }
        }
        enum Characters {
            static let title = "Related Characters"
            static let spacing: CGFloat = 16.0
            static let width: CGFloat = 200.0
            static let height: CGFloat = 140.0
            static let cornerRadius = 12.0
            static let padding: CGFloat = 10.0
        }
        enum Stories {
            static let title = "Related Stories"
            static let horizontalSpacing: CGFloat = 10.0
            static let width: CGFloat = 180.0
            static let cornerRadius = 12.0
        }
        enum Creators {
            static let title = "Related Creators"
            static let horizontalSpacing: CGFloat = 10.0
            static let width: CGFloat = 180.0
            static let cornerRadius = 12.0
            static let overlayStrokeColor = Color.black.opacity(0.7)
            static let overlayStrokeWidth: CGFloat = 2.0
            static let overlayPadding: CGFloat = 1.0
            static let size: CGFloat = 110.0
            static let paddingBottom: CGFloat = 20.0
            static let paddingHorizontal: CGFloat = 15.0
        }
        enum NavBar {
            static let size: CGFloat = 40.0
            static let blur: CGFloat = 20.0
            static let opacityColor: Color = Color.black.opacity(0.3)
            static let padding: CGFloat = 16.0
            static let horizontalPadding: CGFloat = 120.0
        }
    }
}
