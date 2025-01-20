import UIKit

extension UIViewController {
    func showLoading() {
        guard let window = UIApplication.shared.mainKeyWindow else { return }
        let loadingView = LoadingView(frame: window.frame)
        window.addSubview(loadingView)
    }

    func hideLoading() {
        guard let window = UIApplication.shared.mainKeyWindow,
              let loadingView = window.subviews.first(where: { $0 is LoadingView }) else {
            return
        }
        loadingView.removeFromSuperview()
    }
}

extension UIApplication {
    var mainKeyWindow: UIWindow? {
        get {
            if #available(iOS 13, *) {
                return connectedScenes
                    .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                    .first { $0.isKeyWindow }
            } else {
                return keyWindow
            }
        }
    }
}
