//
//  DetailsStub.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class DetailsStub: DetailsWorkerLogic {

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
