//
//  FavoritesModels.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

enum Favorites {
    // MARK: Use cases
    
    enum FetchFavorites {
        struct Request {
        }
        struct Response {
            let characters: [FavoriteCharacter]
        }
        struct ViewModel {
            let characters: [FavoriteCharacter]
        }
    }
    
    enum ErrorMessage {
        struct Request { }
        struct Response {
            let error: ServiceError
        }
        struct ViewModel {
            let message: String
        }
    }
}
