import Foundation
import Combine

// MARK: - Mock Preview -

extension Comic.Detail.ViewModel {
    static var preview: Comic.Detail.ViewModel {
        let viewModel = viewModelMock()

        let model = Comic.Detail.Model(
            comic: comicModel(id: 1),
            creators: creatorsModel(ids: [1, 2]),
            stories: storiesModel(ids: [1, 2]),
            characters: charactersModel(ids: [1, 2])
        )
        viewModel.state = .success(model)
        return viewModel
    }

    static var previewError: Comic.Detail.ViewModel {
        let viewModel = viewModelMock()
        viewModel.state = .failure(ErrorModel.notFound)
        return viewModel
    }

    static var previewLoading: Comic.Detail.ViewModel {
        let viewModel = viewModelMock()
        viewModel.state = .loading
        return viewModel
    }

    private static func viewModelMock() -> Comic.Detail.ViewModel {
        let creatorRepository = Creator.Repository(client: API.MockAPIClient())
        let storyRepository = Story.Repository(client: API.MockAPIClient())
        let characterRepository = Character.Repository(client: API.MockAPIClient())
        let useCases = UseCase.ComicDetailUseCases(
            with: creatorRepository,
            storyRepository: storyRepository,
            characterRepository: characterRepository
        )
        return Comic.Detail.ViewModel(
            coordinator: nil,
            useCases: useCases
        )
    }
}


// MARK: - Mock Preview -

extension Comic.Detail.ViewModel {
    static func comicModel(id: Int? = nil) -> Comic.List.Model {
        let randomId = id ?? Int.random(in: 1...100)
        return Comic.List.Model(
            id: randomId,
            title: "Comic #\(randomId)",
            description: "Description #\(randomId)",
            thumbnail: URL(string: "https://marver/image.jpg"),
            date: Date.fromString("2025-01-31T14:30:45+0000"),
            price: "10.0$"
        )
    }

    // Creators

    static func creatorsModel(ids: [Int]) -> [Creator.List.Model] {
        return ids.map { creatorModel(id: $0) }
    }

    static func creatorModel(id: Int? = nil) -> Creator.List.Model {
        let randomId = id ?? Int.random(in: 1...100)
        return Creator.List.Model(
            id: randomId,
            firstName: "FirstName \(randomId)",
            middleName: "MiddleName \(randomId)",
            fullName: "First middle Name",
            date: Date.fromString("2025-01-31T14:30:45+0000")
        )
    }

    // Characters

    static func charactersModel(ids: [Int]) -> [Character.List.Model] {
        return ids.map { characterModel(id: $0) }
    }

    static func characterModel(id: Int? = nil) -> Character.List.Model {
        let randomId = id ?? Int.random(in: 1...100)
        return Character.List.Model(
            id: randomId,
            name: "Character \(randomId)",
            description: "Description \(randomId)",
            date: Date.fromString("2020-01-01T22:10:01Z")
        )
    }

    // Stories

    static func storiesModel(ids: [Int]) -> [Story.List.Model] {
        return ids.map { storyModel(id: $0) }
    }

    static func storyModel(id: Int? = nil) -> Story.List.Model {
        let randomId = id ?? Int.random(in: 1...100)
        return Story.List.Model(
            id: randomId,
            title: "Story #\(randomId)",
            type: randomId % 2 == 0 ? .story : .cover,
            date: Date.fromString("2025-01-31T14:30:45+0000")
        )
    }
}
