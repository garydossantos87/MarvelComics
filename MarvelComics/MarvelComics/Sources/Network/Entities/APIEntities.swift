import Foundation

enum API {
    enum Method: String {
        case get
        case post
        case put
        case patch
        case delete
    }
    
    enum NetworkError: Error {
        case invalidRequest
        case invalidResponse
        case jsonDecodingError(error: Error)
        case unavailable(statusCode: Int)
    }
    
    enum Headers {
        enum Authorization: String {
            case apikey
            case hash
            
            var name: String {
                switch self {
                case .apikey: "08c6fd830eb3f291f94cbe4f79432f45"
                case .hash: "eb3f9a71bd5727f45c37e2b16362e14e"
                }
            }
        }
        enum Time: String {
            case timeStamp = "ts"
            
            var name: String { "1" } // necessary header for the call
        }
    }
}
