import SwiftUI

extension Character.Detail {
    final class ViewController: UIViewController {
//        private let characterDetailView: Character.Detail.ContentView
        private let viewModel: Character.Detail.ViewModel
        
        init(with viewModel: Character.Detail.ViewModel) {
            self.viewModel = viewModel
            
//            characterDetailView = Character.Detail.ContentView()
//            view.backgroundColor = .red
            super.init(nibName: nil, bundle: nil)
            view.backgroundColor = .red
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}
