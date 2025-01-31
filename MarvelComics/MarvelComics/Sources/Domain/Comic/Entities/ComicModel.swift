//
//  Model.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//


import Foundation

extension Comic.List {
    struct Model: Equatable {
        let id: Int
        let title: String
        let description: String?
        let thumbnail: URL?
        let date: Date?
        let price: String?
        var datePrice: String? {
            if let date = date?.toString(), let price = price {
                return "\(date) | \(price)"
            } else if let date = date?.toString() {
                return date
            } else if let price = price {
                return price
            } else {
                return nil
            }
        }
        
        // MARK: - Init -

        public init(
            id: Int,
            title: String,
            description: String? = nil,
            thumbnail: URL? = nil,
            date: Date? = nil,
            price: String? = nil
        ) {
            self.id = id
            self.title = title
            self.description = description
            self.thumbnail = thumbnail
            self.date = date
            self.price = price
        }

        init(with dto: Comic.Result) {
            self.id = dto.id
            self.title = dto.title
            self.description = dto.description
            self.thumbnail = dto.thumbnailURL
            self.date = dto.onsaleDate
            self.price = dto.formattedPrice
        }
    }
}

// MARK: - Private methods -

private extension Comic.Result {
    var onsaleDate: Date? {
        guard let dateString = dates.first(where: { $0.type == "onsaleDate" })?.date else {
            return nil
        }
        return Date.fromString(dateString)
    }
    
    var formattedPrice: String? {
        guard let price = prices.first?.price, price != 0 else { return nil }
        return "\(price)$"
    }
    
    var thumbnailURL: URL? {
        URL(string: "\(thumbnail.path).\(thumbnail.formatExtension)")
    }
}
