import SwiftUI

extension Character.Detail {
    final class ViewController: UIViewController {
        private let viewModel: Character.Detail.ViewModel
        
        init(with viewModel: Character.Detail.ViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
            view.backgroundColor = .red
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
