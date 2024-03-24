import UIKit

extension UIImageView {
    class func loadGif(with name: String) -> UIImageView? {
        guard let gifPath = Bundle.main.path(forResource: name, ofType: "gif") else {
            print("Failed to find the GIF image.")
            return nil
        }

        guard let gifData = try? Data(contentsOf: URL(fileURLWithPath: gifPath)) else {
            print("Failed to load the GIF image data.")
            return nil
        }

        guard let gifImage = UIImage.gifImageWithData(gifData) else {
            print("Failed to create the GIF image.")
            return nil
        }
        return UIImageView(image: gifImage)
    }
}
