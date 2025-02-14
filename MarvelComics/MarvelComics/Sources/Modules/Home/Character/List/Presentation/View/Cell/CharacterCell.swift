import UIKit

extension Character.List {
    public final class ViewCell: UITableViewCell {
        private let coverImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private let arrowRightImageView: UIImageView = {
            let imageView = UIImageView(image: .icnArrowRigth.withRenderingMode(.alwaysTemplate))
            imageView.tintColor = .primaryColor
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        private lazy var containerInfoStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [titleLabel, dateLabel, descriptionLabel])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = Constants.infoPadding
            stackView.alignment = .leading
            stackView.distribution = .fill
            stackView.axis = .vertical
            return stackView
        }()
        
        private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = Constants.titleFont
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let descriptionLabel: UILabel = {
            let label = UILabel()
            label.font = Constants.descriptionFont
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let dateLabel: UILabel = {
            let label = UILabel()
            label.font = Constants.dateFont
            label.numberOfLines = 1
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private lazy var containerStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [coverImageView, containerInfoStackView, arrowRightImageView])
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = Constants.padding
            stackView.alignment = .center
            return stackView
        }()
        
        // MARK: - Init -
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
        }
                
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        
        // MARK: - Public methods -
        
        func configure(with model: Model) {
            backgroundColor = .white
            coverImageView.setImage(with: model.thumbnail,
                                    placeholder: UIImage.imageNotAvailable)
            titleLabel.text = model.name.uppercased()
            descriptionLabel.text = model.description
            dateLabel.text = model.date?.toString()
        }
    }
}

// MARK: - Private methods -

private extension Character.List.ViewCell {
    func setup() {
        coverImageView.layer.cornerRadius = Constants.cornerRadius
        coverImageView.layer.masksToBounds = true
        addSubview(containerStackView)
        setupConstraint()
    }
    
    func setupConstraint() {
        containerStackView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.padding).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.padding).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.padding).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.padding).isActive = true
                
        let aspectRatio: CGFloat = Constants.coverAspectRatio
        let maxWidth: CGFloat = UIScreen.main.bounds.width
        let imageHeight = min(Constants.coverMaxHeight, maxWidth / aspectRatio)
        let imageWidth = imageHeight * aspectRatio
        coverImageView.widthAnchor.constraint(equalToConstant: imageWidth).isActive = true
        coverImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
        
        arrowRightImageView.widthAnchor.constraint(equalToConstant: Constants.arrowSize).isActive = true
        arrowRightImageView.heightAnchor.constraint(equalToConstant: Constants.arrowSize).isActive = true
    }
}
