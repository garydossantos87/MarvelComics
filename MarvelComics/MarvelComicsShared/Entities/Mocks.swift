import Foundation

public enum MocksUI {
    public enum Constants {
        static let pathMocksReponse: String = "MocksResponse/"
        public enum MocksResponse {
            public static let getComics: String = "get_comics"
        }
    }
}

// MARK: - Public functions -

public extension MocksUI {
    class Helpers {
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
