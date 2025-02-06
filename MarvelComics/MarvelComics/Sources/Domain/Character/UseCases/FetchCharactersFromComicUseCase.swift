//
//  FetchCharactersUseCase.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation
import Combine

extension UseCase {
    struct FetchCharacterFromComicUseCase: FetchCharacterFromComicUseCaseProtocol {
        private let repository: CharacterRepositoryProtocol

        // MARK: - Init -

        init(repository: CharacterRepositoryProtocol) {
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension UseCase.FetchCharacterFromComicUseCase {
    typealias Input = Int
    typealias Output = AnyPublisher<[Character.List.Model], ErrorModel>

    func execute(input: Int) -> AnyPublisher<[Character.List.Model], ErrorModel> {
        repository.fetchCharactersFromComic(with: input)
            .map { $0.data.results.map(Character.List.Model.init) }
            .mapToDomainError()
            .eraseToAnyPublisher()
    }
}
