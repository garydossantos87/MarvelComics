import Kingfisher
import UIKit
import Foundation
import MarvelComicsShared

// MARK: - Kingfisher extensions -

extension UIImageView {
    public func setImage(with url: URL?, placeholder: UIImage?) {
        let isUITests = ProcessInfo.processInfo.isUITests
        let imageURL = isUITests ? URL(string: "") : url
        self.kf.setImage(with: imageURL, placeholder: placeholder)
    }
}

extension KFImage {
    public init(url: URL?) {
        let isUITests = ProcessInfo.processInfo.isUITests
        let imageURL = isUITests ? URL(string: "") : url
        self.init(imageURL)
    }
}
