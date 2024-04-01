import UIKit
import Kingfisher

extension Comic.List {
    final class CollectionViewCell: UICollectionViewCell {
        private let coverImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = Comic.List.CollectionCell.Constants.titleFont
            label.numberOfLines = 1
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = Comic.List.CollectionCell.Constants.descriptionFont
            label.numberOfLines = 1
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let datePriceLabel: UILabel = {
            let label = UILabel()
            label.font = Comic.List.CollectionCell.Constants.priceFont
            label.textColor = .white
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var containerInfoStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, datePriceLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.backgroundColor = Comic.List.CollectionCell.Constants.infoContainerColor
            stackView.axis = .vertical
            return stackView
        }()
        
        private lazy var containerStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [coverImageView, containerInfoStackView])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            return stackView
        }()
        
        // MARK: - Init -
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setup()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - Public methods -
        
        func configure(with model: Model) {
            let width = UIScreen.main.bounds.width / 2
            let resizingProcessor = ResizingImageProcessor(referenceSize: CGSize(width: 130.0, height: 250), mode: .aspectFit)
            coverImageView.kf.setImage(with: model.thumbnail,
                                       placeholder: UIImage.imageNotAvailable,
                                       options: [.processor(resizingProcessor)]
            )
            titleLabel.text = "model.title"
            descriptionLabel.text = "model.description"
            datePriceLabel.text = model.datePrice
        }
    }
}

// MARK: - Private methods -

private extension Comic.List.CollectionViewCell {
    func setup() {
        addSubview(containerStackView)
    }
    
    func setupConstraint() {
        
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        containerInfoStackView.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
    }
}
