import Foundation

extension API {
    enum Endpoints {
        case characters
        case comics
        
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
            }
        }
    }
}
