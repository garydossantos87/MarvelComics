//
//  FetchComicUseCase.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation
import Combine

extension UseCase {
    struct FetchComicsUseCase: FetchComicsUseCaseProtocol {
        private let repository: ComicRepositoryProtocol

        // MARK: - Init -

        init(repository: ComicRepositoryProtocol) {
            self.repository = repository
        }
    }
}

// MARK: - Protocol methods -

extension UseCase.FetchComicsUseCase {
    typealias Input = Void
    typealias Output = AnyPublisher<[Comic.List.Model], API.NetworkError>

    func execute(input: Void = ()) -> Output {
        repository.fetchComics()
            .map { $0.data.results.map(Comic.List.Model.init) }
            .eraseToAnyPublisher()
    }
}
