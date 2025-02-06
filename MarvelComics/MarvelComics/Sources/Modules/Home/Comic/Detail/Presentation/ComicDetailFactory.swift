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
//        let repository = Serie.Repository(client: API.DefaultClient.shared)
//        let useCases = UseCase.SerieUseCases(with: repository)
//        let viewModel = Character.Detail.ViewModel(
//            coordinator: coordinator,
//            useCases: useCases,
//            character: character
//        )
        let rootView = Comic.Detail.MainView(viewModel: .preview)
        return BaseHostingController(rootView: rootView, hideTabBar: true)
    }
}
