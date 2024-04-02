import UIKit

enum Comic {
    enum List {
    }
}

extension Comic.List.View {
    enum Constants {
        static let numbersOfSections: Int = 1
        static let cellPadding = 10.0
    }
}

extension Comic.List.CollectionViewCell {
    enum Constants {
        static let numbersOfSections: Int = 1
        static let reuseIdentifier = String(describing: Comic.List.CollectionViewCell.self)
        static let titleFont = UIFont.boldSystemFont(ofSize: 12.0)
        static let descriptionFont = UIFont.systemFont(ofSize: 12.0)
        static let datePriceFont = UIFont.systemFont(ofSize: 12.0)
        static let infoContainerColor = UIColor.black.withAlphaComponent(0.7)
        static let cornerRadius = 4.0
        static let padding = Comic.List.View.Constants.cellPadding / 2
    }
}
