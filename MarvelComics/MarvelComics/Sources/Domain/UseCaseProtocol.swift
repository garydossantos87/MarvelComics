//
//  UseCaseProtocol.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation
import Combine

protocol UseCaseProtocol {
    associatedtype Input
    associatedtype Output
    func execute(input: Input) -> Output
}

// MARK: - Default implementation -

extension UseCaseProtocol where Input == Void {
    func execute() -> Output {
        return execute(input: ())
    }
}
