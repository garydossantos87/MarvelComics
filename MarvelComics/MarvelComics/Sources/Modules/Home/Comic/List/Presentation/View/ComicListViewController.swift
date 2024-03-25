import UIKit

extension Comic.List {
    final class ViewController: UIViewController {
        
        private let comicListView: Comic.List.View
        private let viewModel: Comic.List.ViewModel
        
        init(with viewModel: Comic.List.ViewModel) {
            self.viewModel = viewModel
            comicListView = Comic.List.View()
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = comicListView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }
}
