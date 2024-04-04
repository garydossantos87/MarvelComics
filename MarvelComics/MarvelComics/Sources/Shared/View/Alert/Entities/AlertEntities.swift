import SwiftUI

enum Alert {
    enum Constants {
        static let backgroundColor: Color = Color.black.opacity(0.2)
        static let spacing: CGFloat = 10.0
        static let cornerRadius: CGFloat = 10.0
        static let horizontalPadding: CGFloat = 40.0
    }
    
    struct Model {
        let title: String
        let subtitle: String
        let actionTitle: String
        let actionHandler: () -> Void
        
        static func defaultError(
            with subtitle: String,
            actionHandler: @escaping () -> Void
        ) -> Model {
            Model(title: "Error",
                  subtitle: subtitle,
                  actionTitle: "OK",
                  actionHandler: actionHandler)
        }
    }
}
