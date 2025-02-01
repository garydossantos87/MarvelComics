//
//  FetchCharactersUseCase.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation
import Combine

extension UseCase {
    struct FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
        private let repository: CharacterRepositoryProtocol

        // MARK: - Init -

        init(repository: CharacterRepositoryProtocol) {
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension UseCase.FetchCharactersUseCase {
    typealias Input = Int?
    typealias Output = AnyPublisher<Character.PaginationModel, ErrorModel>

    func execute(input: Int?) -> AnyPublisher<Character.PaginationModel, ErrorModel> {
        repository.fetchCharacters(with: input)
            .map { Character.PaginationModel.init(with: $0) }
            .mapToDomainError()
            .eraseToAnyPublisher()
    }
}
