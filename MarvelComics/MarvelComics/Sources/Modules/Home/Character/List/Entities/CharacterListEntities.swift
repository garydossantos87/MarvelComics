import UIKit

public enum Character {
    public enum List {
        
    }
}

extension Character.List.ViewCell {
    enum Constants {
        static let reuseIdentifier = String(describing: Character.List.ViewCell.self)
        static let titleFont = UIFont.boldSystemFont(ofSize: 14.0)
        static let descriptionFont = UIFont.systemFont(ofSize: 12.0)
        static let dateFont = UIFont.systemFont(ofSize: 12.0)
        static let cornerRadius = 4.0
        static let padding = 20.0
        static let infoPadding = 5.0
        static let coverAspectRatio: CGFloat = 12.0 / 16.0
        static let coverMaxHeight: CGFloat = 160.0
        static let arrowSize: CGFloat = 24.0
    }
}
