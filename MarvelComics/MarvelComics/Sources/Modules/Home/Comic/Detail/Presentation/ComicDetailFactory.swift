import UIKit
import SwiftUI

extension Comic.Detail {
    struct ViewFactory {
        private let coordinator: ComicDetailCoordinator
        private let comic: Comic.List.Model?

        // MARK: - Init -

        init(with coordinator: ComicDetailCoordinator) {
            self.coordinator = coordinator
            self.comic = nil
        }

        init(
            with coordinator: ComicDetailCoordinator,
            comic: Comic.List.Model? = nil
        ) {
            self.coordinator = coordinator
            self.comic = comic
        }
    }
}

// MARK: - Protocol metods

extension Comic.Detail.ViewFactory: ViewFactory {
    func make() -> UIViewController {
        let creatorRepository = Creator.Repository(client: API.DefaultClient.shared)
        let storyRepository = Story.Repository(client: API.DefaultClient.shared)
        let characterRepository = Character.Repository(client: API.DefaultClient.shared)
        let useCases = UseCase.ComicDetailUseCases(
            with: creatorRepository,
            storyRepository: storyRepository,
            characterRepository: characterRepository
        )
        let viewModel = Comic.Detail.ViewModel(
            coordinator: coordinator,
            useCases: useCases,
            comic: comic)
        let rootView = Comic.Detail.MainView(viewModel: viewModel)
        return BaseHostingController(rootView: rootView, hideTabBar: true)
    }
}
