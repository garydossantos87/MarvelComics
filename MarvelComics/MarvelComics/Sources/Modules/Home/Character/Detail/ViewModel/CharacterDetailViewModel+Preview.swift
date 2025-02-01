import Foundation
import Combine

// MARK: - Mock Preview -

extension Character.Detail.ViewModel {
    static var preview: Character.Detail.ViewModel {
        let viewModel = viewModelMock()
        let characterModel = Character.List.Model(id: 1, name: "Character Name")
        let seriesModel = [
            Serie.List.Model(
                id: 1,
                title: "Serie 1",
                description: "Loremp ipsum dolor sit amet consectetur adipiscing elit sodales vestibulum",
                startYear: 1999,
                endYear: 2010,
                rating: .everyone
            ),
            Serie.List.Model(
                id: 2,
                title: "Serie 2",
                startYear: 1999,
                endYear: 2010,
                rating: .mature
            ),
            Serie.List.Model(
                id: 3,
                title: "Serie 3",
                rating: .teen
            ),
            Serie.List.Model(
                id: 4,
                title: "Serie 4",
                description: "Loremp ipsum dolor sit amet consectetur adipiscing elit sodales vestibulum",
                rating: .teenPlus
            ),
            Serie.List.Model(
                id: 5,
                title: "Serie 5",
                rating: .unrated
            )
        ]

        let model = Character.Detail.Model(
            character: characterModel,
            series: seriesModel
        )
        viewModel.state = .success(model)
        return viewModel
    }

    static var previewError: Character.Detail.ViewModel {
        let viewModel = viewModelMock()
        viewModel.state = .failure(ErrorModel.notFound)
        return viewModel
    }

    static var previewLoading: Character.Detail.ViewModel {
        let viewModel = viewModelMock()
        viewModel.state = .loading
        return viewModel
    }

    private static func viewModelMock() -> Character.Detail.ViewModel {
        let repo = Serie.Repository(client: API.MockAPIClient())
        let useCases = UseCase.SerieUseCases(with: repo)
        return Character.Detail.ViewModel(coordinator: nil, useCases: useCases)
    }
}
