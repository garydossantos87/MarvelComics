import UIKit
import Combine

extension Splash {
    final class ViewController: UIViewController {
        
        private let splashView: Splash.View
        private let viewModel: Splash.ViewModel
        
        init(with viewModel: Splash.ViewModel) {
            self.viewModel = viewModel
            splashView = Splash.View()
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = splashView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }
}
