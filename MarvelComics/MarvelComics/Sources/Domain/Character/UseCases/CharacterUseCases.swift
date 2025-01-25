//
//  ComicUseCases.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation

extension UseCase {
    struct CharacterUseCases {
        let fetchCharacters: UseCase.FetchCharactersUseCase

        // MARK: - Init -

        init(with repository: CharacterRepositoryProtocol) {
            self.fetchCharacters = UseCase.FetchCharactersUseCase(repository: repository)
        }
    }
}
