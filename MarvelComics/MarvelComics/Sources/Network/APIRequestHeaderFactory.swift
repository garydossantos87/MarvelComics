import Foundation

extension API {
    final class RequestHeaderFactory {
        // MARK:  - Lifecycle -
        
        private init() {}
        
        // MARK: - Internal -
        
        static let shared = RequestHeaderFactory()
        
        // MARK: - Private methods -
    
        private var headers: [String: String] = .init()
        
        // MARK: - Public vars/methods -
        
        /// Default Headers for all calls
        var defaultHeaders: [String: String]? {
            return RequestHeaderFactory.shared
                .addAuthorizationHeader(type: .apikey)
                .addTimeHeader(type: .timeStamp)
                .addAuthorizationHeader(type: .hash)
                .build()
        }
        
        @discardableResult
        func addAuthorizationHeader(type: Headers.Authorization) -> RequestHeaderFactory {
            self.headers.updateValue(type.name, forKey: type.rawValue)
            return self
        }
        
        @discardableResult
        func addTimeHeader(type: Headers.Time) -> RequestHeaderFactory {
            self.headers.updateValue(type.name, forKey: type.rawValue)
            return self
        }
        
        func build() -> [String: String] { headers }
    }
}
