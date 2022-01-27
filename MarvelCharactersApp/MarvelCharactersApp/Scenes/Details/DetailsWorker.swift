//
//  DetailsWorker.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol DetailsWorkerLogic {
    func createFavoriteCharactor(character: FavoriteCharacter, completion: @escaping((Result<Bool, ServiceError>) -> Void))
    func deleteFavoriteCharactor(id: Int?, completion: @escaping((Result<Bool, ServiceError>) -> Void))
}

class DetailsWorker: DetailsWorkerLogic {
    
    func createFavoriteCharactor(character: FavoriteCharacter, completion: @escaping((Result<Bool, ServiceError>) -> Void)) {
        FavoriteCharacterRepository.shared.create { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func deleteFavoriteCharactor(id: Int?, completion: @escaping((Result<Bool, ServiceError>) -> Void)) {
        FavoriteCharacterRepository.shared.delete(id: id) { result in
            switch result {
            case .success(_):
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
