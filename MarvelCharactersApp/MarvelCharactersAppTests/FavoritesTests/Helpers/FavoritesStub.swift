//
//  FavoritesStub.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class FavoritesStub: FavoritesWorkerLogic {
    var invokedFetchFavorites = false
    var fetchFavoritesResponse: Result<[FavoriteCharacter], ServiceError> = .failure(.defaultError)
    
    func fetchFavorites(completion: @escaping (Result<[FavoriteCharacter], ServiceError>) -> Void) {
        invokedFetchFavorites = true
        completion(fetchFavoritesResponse)
    }
}
