import UIKit
import SwiftUI

extension Character.Detail {
    struct ViewFactory {
        private let coordinator: CharacterDetailCoordinator
        private let character: Character.List.Model?

        // MARK: - Init -

        init(with coordinator: CharacterDetailCoordinator) {
            self.coordinator = coordinator
            self.character = nil
        }

        init(
            with coordinator: CharacterDetailCoordinator,
            character: Character.List.Model? = nil
        ) {
            self.coordinator = coordinator
            self.character = character
        }
    }
}

// MARK: - Protocol metods

extension Character.Detail.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let repository = Serie.Repository(client: API.DefaultClient.shared)
        let useCases = UseCase.SerieUseCases(with: repository)
        let viewModel = Character.Detail.ViewModel(
            coordinator: coordinator,
            useCases: useCases,
            character: character
        )
        let rootView = Character.Detail.MainView(viewModel: viewModel)
        return BaseHostingController(rootView: rootView, hideTabBar: true)
    }
}
