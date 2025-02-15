import Foundation

public enum MocksEnpoint {
    case comics
    case characters
    
    var path: String {
        switch self {
        case .comics: return "/comics"
        case .characters: return "/characters"
        }
    }
    
    var data: Data? {
        switch self {
        case .comics: return Helper.loadJSONFromFile(named: Constants.FileName.getComics)
        case .characters: return Helper.loadJSONFromFile(named: Constants.FileName.getCharacters)
        }
    }
}

// MARK: - Public functions -

private extension MocksEnpoint {
    enum Constants {
        public enum FileName {
            public static let getComics: String = "get_comics"
            public static let getCharacters: String = "get_characters"
        }
    }
    
    class Helper {
        public static func printFilesInBundle() {
            let bundle = Bundle(for: Self.self)
            
            do {
                let fileURLs = try FileManager.default.contentsOfDirectory(at: bundle.bundleURL,
                                                                           includingPropertiesForKeys: nil,
                                                                           options: [])
                let fileNames = fileURLs.map { $0.lastPathComponent }
                print("✅ Files in bundle: \(fileNames)")
            } catch {
                print("❌ Error reading files in bundle: \(error)")
            }
        }
        
        public static func loadJSONFromFile(named fileName: String) -> Data? {
            let bundle = Bundle(for: Self.self)
            
            guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
                print("❌ Mock JSON file \(fileName).json not found in the bundle")
                return nil
            }
            return try? Data(contentsOf: url)
        }
    }
}
