import UIKit
import SwiftUI

extension Character.Detail {
    struct ViewFactory {
        private let coordinator: BaseCoordinator

        // MARK: - Init -
        
        init(with coordinator: BaseCoordinator) {
            self.coordinator = coordinator
        }
    }
}

// MARK: - Protocol metods

extension Character.Detail.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let viewModel = Character.Detail.ViewModel(coordinator: coordinator)
        let rootView = Character.Detail.MainView(viewModel: viewModel)
        return UIHostingController(rootView: rootView)
    }
}
