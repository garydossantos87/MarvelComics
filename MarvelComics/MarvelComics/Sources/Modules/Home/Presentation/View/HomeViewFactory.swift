import UIKit
public extension Home {
    struct ViewFactory {
        //MARK: - Init
        
        init() {
        }
    }
}

//MARK: - Protocol metods

extension Home.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Home.ViewModel()
        return Home.ViewController(with: viewModel)
    }
}
