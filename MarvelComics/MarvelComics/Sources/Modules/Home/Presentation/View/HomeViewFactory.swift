import UIKit
public extension Home {
    struct ViewFactory {
        private let coordinator: BaseCoordinator
        
        //MARK: - Init
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
        }
    }
}

//MARK: - Protocol metods

extension Home.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Home.ViewModel(coordinator: coordinator)
        return Home.ViewController(with: viewModel)
    }
}
