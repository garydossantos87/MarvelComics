import UIKit
import Kingfisher
import MarvelComicsShared

extension Splash {
    final class View: UIView {
        private let containerView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        private let imageViewLogo: UIImageView = {
            let imageView = UIImageView(image: .marvelComicsLogo)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleToFill
            imageView.accessibilityIdentifier = AccessibilityIdentifiers.Splash.imageViewLogoID
            return imageView
        }()
        
        private let loaderGif: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            guard let path = Bundle.main
                .url(forResource: Constants.gifName, withExtension: Constants.gifExtension) else {
                return UIImageView()
            }
            let resource = LocalFileImageDataProvider(fileURL: path)
            imageView.kf.setImage(with: resource)
            imageView.accessibilityIdentifier = AccessibilityIdentifiers.Splash.loaderGifID
            return imageView
        }()
        
        // MARK: - Public methods -
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        // MARK: - Private methods -
        
        private func setup() {
            backgroundColor = .white
            containerView.addSubview(imageViewLogo)
            containerView.addSubview(loaderGif)
            addSubview(containerView)
            setupConstraints()
        }
        
        private func setupConstraints() {
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            
            let widthLogo = UIScreen.main.bounds.width * 0.75
            let heightLogo = widthLogo - 100.0
            imageViewLogo.heightAnchor.constraint(equalToConstant: heightLogo).isActive = true
            imageViewLogo.widthAnchor.constraint(equalToConstant: widthLogo).isActive = true
            imageViewLogo.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            let topAnchor = (UIScreen.main.bounds.height - (heightLogo + Constants.Size.loaderSize)) / 2
            imageViewLogo.topAnchor.constraint(equalTo: containerView.topAnchor, constant: topAnchor).isActive = true

            loaderGif.heightAnchor.constraint(equalToConstant: Constants.Size.loaderSize).isActive = true
            loaderGif.widthAnchor.constraint(equalToConstant: Constants.Size.loaderSize).isActive = true
            loaderGif.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
            loaderGif.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor).isActive = true
        }
    }
}
