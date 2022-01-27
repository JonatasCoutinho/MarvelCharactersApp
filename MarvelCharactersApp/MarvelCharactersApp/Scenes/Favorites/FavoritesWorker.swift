//
//  FavoritesWorker.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol FavoritesWorkerLogic {
    func fetchFavorites(completion: @escaping (Result<[FavoriteCharacter], ServiceError>) -> Void)
}

class FavoritesWorker: FavoritesWorkerLogic {
    func fetchFavorites(completion: @escaping (Result<[FavoriteCharacter], ServiceError>) -> Void) {
        
        FavoriteCharacterRepository.shared.fetch { result in
            completion(result)
        }
    }
}
