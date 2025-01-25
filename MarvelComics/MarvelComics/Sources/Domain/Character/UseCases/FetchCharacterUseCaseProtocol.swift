//
//  FetchCharactersUseCaseProtocol.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation
import Combine

protocol FetchCharactersUseCaseProtocol: UseCaseProtocol where Input == Int?, Output == AnyPublisher<Character.PaginationModel, API.NetworkError> {
    func execute(input: Int?) -> AnyPublisher<Character.PaginationModel, API.NetworkError>
}
