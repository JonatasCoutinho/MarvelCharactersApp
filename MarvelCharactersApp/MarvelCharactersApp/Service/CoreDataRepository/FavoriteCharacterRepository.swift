//
//  FavoriteCharacterRepository.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 27/01/22.
//

import UIKit
import CoreData

private protocol FavoriteCharacterInterface{
    func fetch(completion: @escaping(Result<[FavoriteCharacter], ServiceError>)->Void)
    
    func create(completion: @escaping(Result<Bool, ServiceError>)->Void)
    
    func delete(id: Int?, completion: @escaping(Result<Bool, ServiceError>)->Void)
}

class FavoriteCharacterRepository {
    
    private lazy var repository: CoreDataRepository<FavoriteCharacter> = {
        return CoreDataRepository<FavoriteCharacter>(managedContext: context)
    }()
                                                     
    lazy var context: NSManagedObjectContext = {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }()
    
    static var shared: FavoriteCharacterRepository = {
        let instance = FavoriteCharacterRepository()
        return instance
    }()
    
    private init() { }
}

extension FavoriteCharacterRepository: FavoriteCharacterInterface {
    func fetch(completion: @escaping (Result<[FavoriteCharacter], ServiceError>) -> Void) {
        repository.fetch { result in
            completion(result)
        }
    }
    
    func create(completion: @escaping (Result<Bool, ServiceError>) -> Void) {
        repository.create { result in
            completion(result)
        }
    }
    
    func delete(id: Int?, completion: @escaping (Result<Bool, ServiceError>) -> Void) {
        repository.delete(id: id) { result in
            completion(result)
        }
    }
}
