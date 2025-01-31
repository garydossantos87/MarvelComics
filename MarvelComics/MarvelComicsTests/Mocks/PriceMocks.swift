//
//  PriceMocks.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 31/1/25.
//

import Foundation
@testable import MarvelComics

extension Mocks {
    static var priceResult: PriceResult {
        PriceResult(type: "printPrice", price: 10.0)
    }
}
