import Foundation

extension API {
    enum Endpoints {
        case characters
        case comics
        case series(Int)
        case creators(Int)
        case stories(Int)
        case charactersForComic(Int)

        // MARK: - Private vars -
        
        var url: URL? { URL(string: baseURL.appending(path)) }
        
        // MARK: - Private vars -
        
        private var baseURL: String {
            return "https://gateway.marvel.com/v1/public/"
        }
        
        private var path: String {
            switch self {
            case .characters: "characters"
            case .comics: "comics"
            case .series(let characterId): "characters/\(characterId)/series"
            case .creators(let comicId): "comics/\(comicId)/creators"
            case .stories(let comicId): "comics/\(comicId)/stories"
            case .charactersForComic(let comicId): "comics/\(comicId)/characters"
            }
        }
    }
}
