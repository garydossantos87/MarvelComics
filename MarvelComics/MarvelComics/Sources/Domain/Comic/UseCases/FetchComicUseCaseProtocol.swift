//
//  FetchComicUseCaseProtocol.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation
import Combine

protocol FetchComicsUseCaseProtocol: UseCaseProtocol where Input == Void, Output == AnyPublisher<[Comic.List.Model], API.NetworkError> {
    func execute() -> AnyPublisher<[Comic.List.Model], API.NetworkError>
}
