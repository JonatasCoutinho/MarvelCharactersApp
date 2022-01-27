//
//  MarvelApiError.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import Foundation

enum ServiceError: Error{
    case defaultError
    
    var message: String {
        switch self {
        case .defaultError:
            return "Service unavailable, try again later."
        }
    }
}
