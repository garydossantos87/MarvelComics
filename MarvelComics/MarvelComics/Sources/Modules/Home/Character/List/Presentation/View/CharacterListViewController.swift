import UIKit

extension Character.List {
    final class ViewController: UIViewController {
        
        private let characterListView: Character.List.View
        private let viewModel: Character.List.ViewModel
        
        init(with viewModel: Character.List.ViewModel) {
            self.viewModel = viewModel
            characterListView = Character.List.View()
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = characterListView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }
}
