//
//  CoreDataRespository.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 27/01/22.
//

import Foundation
import CoreData

import Foundation

protocol Repository {
    associatedtype Entity
    
    func fetch(completion: @escaping(Result<[Entity], ServiceError>)->Void)
    
    func create(completion: @escaping(Result<Bool, ServiceError>)->Void)
    
    func delete(id: Int?, completion: @escaping(Result<Bool, ServiceError>)->Void)
}


class CoreDataRepository<T: NSManagedObject>: Repository{
    typealias Entity = T
    
    private let managedContext: NSManagedObjectContext
    
    init(managedContext: NSManagedObjectContext) {
        self.managedContext = managedContext
    }
    
    func fetch(completion: @escaping(Result<[Entity], ServiceError>)->Void) {
        do {
            if let entitys: [Entity] = try managedContext.fetch(Entity.fetchRequest()) as? [T] {
                completion(.success(entitys))
            }else {
                completion(.failure(.defaultError))
            }
        } catch {
            completion(.failure(.defaultError))
        }
    }
    
    func create(completion: @escaping(Result<Bool, ServiceError>)->Void) {
        do {
            try managedContext.save()
            completion(.success(true))
            
        } catch {
            completion(.failure(.defaultError))
        }
    }
    
    func delete(id: Int?, completion: @escaping(Result<Bool, ServiceError>)->Void) {
        
        guard let id = id else {
            completion(.failure(.defaultError))
            return
        }
        
        let predicate = NSPredicate(format: "id == %d", Int64(id) as CVarArg)
        
        let request = Entity.fetchRequest()
        request.predicate = predicate
        
        do {
            guard let entity = try managedContext.fetch(request).first else {
                return
            }
            managedContext.delete(entity as! NSManagedObject)
            try managedContext.save()
            completion(.success(true))
            
        } catch {
            completion(.failure(.defaultError))
        }
    }
}
