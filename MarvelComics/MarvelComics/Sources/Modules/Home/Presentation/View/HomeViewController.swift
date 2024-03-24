import UIKit
import Combine

extension Home {
    final class ViewController: UIViewController {
        
        private let homeView: Home.View
        private let viewModel: Home.ViewModel
        
        init(with viewModel: Home.ViewModel) {
            self.viewModel = viewModel
            homeView = Home.View()
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = homeView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configure()
        }
        
        // MARK: - Private Method -
        
        private func configure() {
           
        }
    }
}

