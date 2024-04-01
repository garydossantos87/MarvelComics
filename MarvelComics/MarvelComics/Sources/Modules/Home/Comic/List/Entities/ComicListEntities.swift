import UIKit

enum Comic {
    enum List {
        enum CollectionView {
            static let numbersOfSections: Int = 1
        }
        enum CollectionCell {
            enum Constants {
                static let reuseIdentifier = String(describing: CollectionViewCell.self)
                static let titleFont = UIFont.boldSystemFont(ofSize: 13.0)
                static let descriptionFont = UIFont.systemFont(ofSize: 12.0)
                static let priceFont = UIFont.systemFont(ofSize: 12.0)
                static let infoContainerColor = UIColor.black.withAlphaComponent(0.7)
            }
        }
    }
}
