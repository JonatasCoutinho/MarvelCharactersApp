//
//  DetailsModels.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

enum Details {
    enum CharacterInfo {
        struct Request { }
        struct Response {
            let character: Character?
        }
        struct ViewModel {
            let character: Character?
            let name: String?
            let detail: String?
            let image: UIImage
        }
    }
    
    enum SaveFavoriteStatus {
        struct Request { }
        struct Response {
            let character: Character?
        }
        struct ViewModel {
            let character: Character?
            let name: String?
            let detail: String?
            let image: UIImage
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
