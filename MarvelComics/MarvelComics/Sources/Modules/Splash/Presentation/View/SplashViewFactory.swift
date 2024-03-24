import UIKit

public extension Splash {
    struct ViewFactory {
        
        // MARK: - Init -
        
        init() {
        }
    }
}

//MARK: - Protocol methods -

extension Splash.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Splash.ViewModel()
        return Splash.ViewController(with: viewModel)
    }
}
