import UIKit
import Kingfisher

extension Comic.List {
    final class CollectionViewCell: UICollectionViewCell {
        private let coverImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
            imageView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
            return imageView
        }()

        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = Constants.titleFont
            label.numberOfLines = 2
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = Constants.descriptionFont
            label.numberOfLines = 2
            label.textColor = .white
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private let datePriceLabel: UILabel = {
            let label = UILabel()
            label.font = Constants.datePriceFont
            label.textColor = .white
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        private lazy var containerInfoStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, datePriceLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.setContentHuggingPriority(.defaultHigh, for: .vertical)
            stackView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            return stackView
        }()

        private let containerInfoView: UIView = {
            let view = UIView()
            view.backgroundColor = .primaryColor
            view.translatesAutoresizingMaskIntoConstraints = false
            view.setContentHuggingPriority(.defaultHigh, for: .vertical)
            view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
            return view
        }()

        private lazy var containerStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [coverImageView, containerInfoView])
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

        override func prepareForReuse() {
            super.prepareForReuse()
            coverImageView.kf.cancelDownloadTask()
            coverImageView.image = nil
            titleLabel.text = nil
            descriptionLabel.text = nil
            datePriceLabel.text = nil
        }


        // MARK: - Public methods -

        func configure(with model: Model) {
            coverImageView.kf.setImage(with: model.thumbnail,
                                       placeholder: UIImage.imageNotAvailable)
            titleLabel.text = model.title
            descriptionLabel.text = model.description
            datePriceLabel.text = model.datePrice
        }
    }
}

// MARK: - Private methods -

private extension Comic.List.CollectionViewCell {
    func setup() {
        containerStackView.layer.cornerRadius = Constants.cornerRadius
        containerStackView.layer.masksToBounds = true
        containerInfoView.addSubview(containerInfoStackView)
        addSubview(containerStackView)
        setupConstraint()
    }

    func setupConstraint() {
        containerStackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        containerInfoStackView.topAnchor.constraint(equalTo: containerInfoView.topAnchor, constant: Constants.padding).isActive = true
        containerInfoStackView.leadingAnchor.constraint(equalTo: containerInfoView.leadingAnchor, constant: Constants.padding).isActive = true
        containerInfoStackView.trailingAnchor.constraint(equalTo: containerInfoView.trailingAnchor, constant: -Constants.padding).isActive = true
        containerInfoStackView.bottomAnchor.constraint(equalTo: containerInfoView.bottomAnchor, constant: -Constants.padding).isActive = true
    }
}
