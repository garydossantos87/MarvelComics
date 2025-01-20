import SwiftUI
import UIKit

extension UIViewController {
    func showAlert(with model: Alert.Model) {
        let alertView = Alert.MainView(model: model)
        let alertViewController = UIHostingController(rootView: alertView)
        alertViewController.modalPresentationStyle = .overFullScreen
        alertViewController.view.backgroundColor = .white.withAlphaComponent(0.7)
        present(alertViewController, animated: true, completion: nil)
    }
    
    func hideAlert() {
        guard let presentedViewController = presentedViewController as? UIHostingController<Alert.MainView> else { return }
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
