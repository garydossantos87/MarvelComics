//
//  ComicMocks.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 31/1/25.
//

import Foundation
@testable import MarvelComics

extension Mocks {
    static func comicsModel(ids: [Int]) -> [Comic.List.Model] {
        return ids.map { comicModel(id: $0) }
    }

    static func comicModel(id: Int? = nil) -> Comic.List.Model {
        let randomId = id ?? Int.random(in: 1...100)
        return Comic.List.Model(
            id: randomId, 
            title: "Comic #\(randomId)",
            description: "Description #\(randomId)",
            thumbnail: URL(string: "https://marver/image.jpg"),
            date: Date.fromString("2025-01-31T14:30:45+0000"),
            price: "10.0$"
        )
    }

    static func comicResult(id: Int? = nil) -> Comic.Result {
        let randomId = id ?? Int.random(in: 1...100)
        return Comic.Result(
            id: randomId,
            title: "Comic #\(randomId)",
            description: "Description #\(randomId)",
            dates: [dateResult],
            prices: [priceResult],
            thumbnail: thumbnailResult
        )
    }

    static func comicsResult(ids: [Int]) -> [Comic.Result] {
        return ids.map { comicResult(id: $0) }
    }

    static func comicListResult(ids: [Int]) -> Comic.ListResult {
        let comicsResult = comicsResult(ids: ids)
        return Comic.ListResult(data: DataResult(
            offset: 0,
            limit: 0,
            total: 20,
            count: comicsResult.count,
            results: comicsResult)
        )
    }
}
