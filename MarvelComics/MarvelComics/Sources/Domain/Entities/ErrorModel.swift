//
//  ErrorModel.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 1/2/25.
//

import Foundation

enum ErrorModel: Error, Equatable {
    case networkFailure
    case decodingError
    case unauthorized
    case notFound
    case serverError
    case unknown(String)

    var name: String {
        switch self {
        case .networkFailure:
            return "Network error. Please check your connection."
        case .decodingError:
            return "Failed to process data. Please try again."
        case .unauthorized:
            return "You are not authorized to perform this action."
        case .notFound:
            return "Requested data not found."
        case .serverError:
            return "Server is currently unavailable. Please try later."
        case .unknown(let message):
            return "An unexpected error occurred: \(message)"
        }
    }
}

// MARK: - DomainError Extension -

extension ErrorModel {
    static func from(_ apiError: API.NetworkError) -> ErrorModel {
        switch apiError {
        case .networkFailure:
            return .networkFailure
        case .jsonDecodingError,
             .invalidRequest,
             .invalidResponse:
            return .decodingError
        case .badServerResponse(let statusCode):
            switch statusCode {
            case 401: return .unauthorized
            case 404: return .notFound
            case 500...599: return .serverError
            default: return .unknown("HTTP \(statusCode)")
            }
        case .unknown(let error):
            return .unknown(error.localizedDescription)
        }
    }
}
