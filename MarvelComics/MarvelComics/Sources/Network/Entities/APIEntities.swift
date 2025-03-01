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
        case networkFailure
        case jsonDecodingError(error: Error)
        case unknown(error: Error)
        case badServerResponse(statusCode: Int)

        var name: String {
            switch self {
            case .unknown(let error): return "Unknown error \n\(error.localizedDescription)"
            case .badServerResponse(let statusCode): return "Bad server error, statusCode: \(statusCode)"
            case .invalidRequest: return "Invalid request"
            case .invalidResponse: return "Invalid response"
            case .jsonDecodingError(let error): return "Decoding Error \n\(error.localizedDescription)"
            case .networkFailure: return "Unknown error"
            }
        }
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
        enum Pagination: String {
            case offset
        }
    }
}

// MARK: - Equatable Extension -

extension API.NetworkError: Equatable {
    static func == (lhs: API.NetworkError, rhs: API.NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidRequest, .invalidRequest),
            (.invalidResponse, .invalidResponse):
            return true
        case (.badServerResponse(let code1), .badServerResponse(let code2)):
            return code1 == code2
        case (.jsonDecodingError, .jsonDecodingError),
            (.unknown, .unknown),
            (.networkFailure, .networkFailure):
            return true
        default:
            return false
        }
    }
}
