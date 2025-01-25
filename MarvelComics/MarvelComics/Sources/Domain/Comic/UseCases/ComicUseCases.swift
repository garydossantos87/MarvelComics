//
//  ComicUseCases.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation

extension UseCase {
    struct ComicUseCases {
        let fetchComics: UseCase.FetchComicsUseCase

        // MARK: - Init -

        init(with repository: ComicRepositoryProtocol) {
            self.fetchComics = UseCase.FetchComicsUseCase(repository: repository)
        }
    }
}
