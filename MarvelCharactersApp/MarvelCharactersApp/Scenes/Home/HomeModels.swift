//
//  HomeModels.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

enum Home {

    enum FetchCharacters {
        struct Request { }
        struct Response {
            let characters: [Character]?
        }
        struct ViewModel {
            let characters: [Character]?
        }
    }
    
    enum FilterCharacters {
        struct Request {
            let searchText: String?
        }
        struct Response {
            let characters: [Character]?
        }
        struct ViewModel {
            let characters: [Character]?
        }
    }
    
    enum UpdateCharacter {
        struct Request {
            let character: Character?
        }
        struct Response {
            let characters: [Character]?
        }
        struct ViewModel {
            let characters: [Character]?
        }
    }
    
    enum SaveFavoriteStatus {
        struct Request {
            let character: Character?
        }
        struct Response {
            let characters: [Character]?
        }
        struct ViewModel {
            let characters: [Character]?
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
