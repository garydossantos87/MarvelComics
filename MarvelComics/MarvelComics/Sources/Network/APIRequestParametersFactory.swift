import Foundation

extension API {
    final class RequestParametersFactory {
        // MARK:  - Lifecycle -
        
        private init() {}
        
        // MARK: - Internal -
        
        static let shared = RequestParametersFactory()
        
        // MARK: - Private methods -
    
        private var headers: [String: String] = .init()
        
        // MARK: - Public vars/methods -
        
        /// Default Headers for all calls
        var defaultHeaders: [String: String]? {
            return RequestParametersFactory.shared
                .addAuthorizationHeader(type: .apikey)
                .addTimeHeader(type: .timeStamp)
                .addAuthorizationHeader(type: .hash)
                .build()
        }
        
        @discardableResult
        func addAuthorizationHeader(type: Headers.Authorization) -> RequestParametersFactory {
            self.headers.updateValue(type.name, forKey: type.rawValue)
            return self
        }
        
        @discardableResult
        func addOffsetHeader(type: Headers.Pagination, offset: Int) -> RequestParametersFactory {
            self.headers.updateValue(String(offset), forKey: type.rawValue)
            return self
        }
        
        @discardableResult
        func addTimeHeader(type: Headers.Time) -> RequestParametersFactory {
            self.headers.updateValue(type.name, forKey: type.rawValue)
            return self
        }
        
        func build() -> [String: String] { headers }
    }
}
