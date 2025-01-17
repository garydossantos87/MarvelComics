//
//  Mocks.swift
//  MarvelComicsTests
//
//  Created by Gary Dos Santos de Andrade on 17/1/25.
//

import Foundation
@testable import MarvelComics

enum Mocks {
    static func characterModel(
        name: String = "Name",
        description: String? = "Description",
        date: Date? = Date.fromString("2020-01-01T22:10:01Z")
    ) -> Character.List.Model {
        return Character.List.Model(
            name: name,
            description: description,
            date: date
        )
    }
}
