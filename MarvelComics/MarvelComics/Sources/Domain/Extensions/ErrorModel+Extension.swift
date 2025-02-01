//
//  ErrorModel+Extension.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 1/2/25.
//

import Foundation
import Combine

extension Publisher where Failure == API.NetworkError {
    func mapToDomainError() -> AnyPublisher<Output, ErrorModel> {
        mapError { ErrorModel.from($0) }.eraseToAnyPublisher()
    }
}
