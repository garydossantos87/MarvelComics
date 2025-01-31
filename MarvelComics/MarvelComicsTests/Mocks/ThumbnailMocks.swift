//
//  ThumbnailMocks.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 31/1/25.
//


import Foundation
@testable import MarvelComics

extension Mocks {
    static var thumbnailResult: ThumbnailResult {
        ThumbnailResult(path: "https://marver/image", formatExtension: "jpg")
    }
}
