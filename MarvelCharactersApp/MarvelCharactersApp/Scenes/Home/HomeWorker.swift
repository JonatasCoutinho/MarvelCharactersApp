//
//  HomeWorker.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol HomeWorkerLogic {
    func fetchCharacters(completion: @escaping (Result<[Character], ServiceError>) -> Void)
    func fetchCharactersImage(characters: [Character], completion: @escaping(([Character]) -> Void))
    func fetchFavoritesIds(completion: @escaping (Result<[Int], ServiceError>) -> Void)
    func createFavoriteCharactor(character: FavoriteCharacter, completion: @escaping((Result<Bool, ServiceError>) -> Void))
    func deleteFavoriteCharactor(id: Int?, completion: @escaping((Result<Bool, ServiceError>) -> Void))
}

class HomeWorker: HomeWorkerLogic {
    func fetchCharacters(completion: @escaping (Result<[Character], ServiceError>) -> Void) {
        
        MarvelService.shared.fetchContent(request: MarvelCharacterRequest()) { (result: Result<MarvelCharacterResponse, ServiceError>) in
            
            switch result {
            case .success(let result):
                guard let characters = result.data?.results else {
                    completion(.failure(.defaultError))
                    return
                }
                
                completion(.success(characters))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCharactersImage(characters: [Character], completion: @escaping(([Character]) -> Void)) {
        var charactersWithImage: [Character] = []
        let myGroup = DispatchGroup()
        
        for var character in characters {
            
            guard let url = character.thumbnail?.url else {
                character.image = UIImage(systemName: "clear")
                charactersWithImage.append(character)
                continue
            }
            
            myGroup.enter()
            
            MarvelService.shared.fetchContentWithURL(url: url) { result in
                
                switch result {
                case .success(let data):
                    character.image = UIImage(data: data)
                    charactersWithImage.append(character)
                case .failure(_):
                    character.image = UIImage(systemName: "clear")
                    charactersWithImage.append(character)
                }
                
                myGroup.leave()
            }
        }
        
        myGroup.notify(queue: .main) {
            completion(charactersWithImage)
        }
    }
    
    func fetchFavoritesIds(completion: @escaping (Result<[Int], ServiceError>) -> Void) {
        FavoriteCharacterRepository.shared.fetch { result in
            switch result {
            case .success(let characters):
                let charactersID = characters.map({ character in
                    Int(character.id)
                })
                
                completion(.success(charactersID))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createFavoriteCharactor(character: FavoriteCharacter, completion: @escaping((Result<Bool, ServiceError>) -> Void)) {
        FavoriteCharacterRepository.shared.create { result in
            completion(result)
        }
    }
    
    
    func deleteFavoriteCharactor(id: Int?, completion: @escaping((Result<Bool, ServiceError>) -> Void)) {
        FavoriteCharacterRepository.shared.delete(id: id) { result in
            completion(result)
        }
    }
}
