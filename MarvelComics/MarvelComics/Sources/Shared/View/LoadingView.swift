import UIKit
import Kingfisher

final class LoadingView: UIView {
    enum Constants {
        enum Size {
            static let loaderSize: CGFloat = 70.0
        }
        static let gifName: String = "loading"
        static let gifExtension: String = "gif"
        static let backgroundColor: UIColor = .white.withAlphaComponent(0.6)
    }
    
    private let loaderGif: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        guard let path = Bundle.main
            .url(forResource: Constants.gifName, withExtension: Constants.gifExtension) else {
            return UIImageView()
        }
        let resource = LocalFileImageDataProvider(fileURL: path)
        imageView.kf.setImage(with: resource)
        return imageView
    }()
    
    // MARK: - Init -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Private func -
    
    private func setup() {
        backgroundColor = Constants.backgroundColor
        addSubview(loaderGif)
        setupConstraints()
    }
    
    private func setupConstraints() {
        loaderGif.heightAnchor.constraint(equalToConstant: Constants.Size.loaderSize).isActive = true
        loaderGif.widthAnchor.constraint(equalToConstant: Constants.Size.loaderSize).isActive = true
        loaderGif.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loaderGif.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
