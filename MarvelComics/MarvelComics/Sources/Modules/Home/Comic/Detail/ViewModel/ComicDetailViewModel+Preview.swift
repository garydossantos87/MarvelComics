import Foundation
import Combine

// MARK: - Mock Preview -

extension Comic.Detail.ViewModel {
    static var preview: Comic.Detail.ViewModel {
        let viewModel = viewModelMock()
        viewModel.state = .success()
        return viewModel
    }

//    static var previewError: Character.Detail.ViewModel {
//        let viewModel = viewModelMock()
//        viewModel.state = .failure(ErrorModel.notFound)
//        return viewModel
//    }
//
//    static var previewLoading: Character.Detail.ViewModel {
//        let viewModel = viewModelMock()
//        viewModel.state = .loading
//        return viewModel
//    }

    private static func viewModelMock() -> Comic.Detail.ViewModel {
        let repo = Serie.Repository(client: API.MockAPIClient())
        let useCases = UseCase.SerieUseCases(with: repo)
        return Comic.Detail.ViewModel(coordinator: nil, useCases: useCases)
    }
}
