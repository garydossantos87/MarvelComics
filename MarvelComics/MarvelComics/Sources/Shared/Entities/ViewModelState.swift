//
//  ViewModelState.swift
//  MarvelComics
//
//  Created by Gary Dos Santos de Andrade on 20/1/25.
//

import Foundation

enum ViewModelState: Equatable {
    case loading
    case success(Any? = nil)
    case failure(Error)
    
    static func == (lhs: ViewModelState, rhs: ViewModelState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.success, .success):
            return true 
        case (.failure, .failure):
            return true
        default:
            return false
        }
    }
}
