//
//  HomeStub.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class HomeStub: HomeWorkerLogic {

    var invokedFetchCharacters = false
    var fetchCharactersResponse: Result<[Character], ServiceError> = .failure(.defaultError)
    
    func fetchCharacters(completion: @escaping (Result<[Character], ServiceError>) -> Void) {
        invokedFetchCharacters = true
        completion(fetchCharactersResponse)
    }

    var invokedFetchCharactersImage = false
    var fetchCharactersImageResponse: [Character] = []

    func fetchCharactersImage(characters: [Character], completion: @escaping(([Character]) -> Void)) {
        invokedFetchCharactersImage = true
        completion(fetchCharactersImageResponse)
    }
    
    var invokedFetchFavoritesIds = false
    var fetchFavoritesIdsResponse: Result<[Int], ServiceError> = .failure(.defaultError)

    func fetchFavoritesIds(completion: @escaping (Result<[Int], ServiceError>) -> Void) {
        invokedFetchFavoritesIds = true
        completion(fetchFavoritesIdsResponse)
    }
    
    var invokedCreateFavoriteCharactor = false
    var createFavoriteCharactorResponse: Result<Bool, ServiceError> = .failure(.defaultError)
    
    func createFavoriteCharactor(character: FavoriteCharacter, completion: @escaping ((Result<Bool, ServiceError>) -> Void)) {
        invokedCreateFavoriteCharactor = true
        completion(createFavoriteCharactorResponse)
    }
    
    var invokedDeleteFavoriteCharactor = false
    var deleteFavoriteCharactorResponse: Result<Bool, ServiceError> = .failure(.defaultError)
    
    func deleteFavoriteCharactor(id: Int?, completion: @escaping ((Result<Bool, ServiceError>) -> Void)) {
        invokedDeleteFavoriteCharactor = true
        completion(deleteFavoriteCharactorResponse)
    }
}
