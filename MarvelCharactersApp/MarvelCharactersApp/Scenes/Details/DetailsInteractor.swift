//
//  DetailsInteractor.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol DetailsBusinessLogic {
    func handleGetCharacterInfo(request: Details.CharacterInfo.Request)
    func handleSaveFavoriteStatus(request: Details.SaveFavoriteStatus.Request)
}

protocol DetailsDataStore {
    var character: Character? { get set }
}

class DetailsInteractor: DetailsDataStore {
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorkerLogic?
    
    var character: Character?
}

extension DetailsInteractor: DetailsBusinessLogic {
    func handleGetCharacterInfo(request: Details.CharacterInfo.Request) {
        presenter?.presentCharacterInfo(response: .init(character: character))
    }
    
    func handleSaveFavoriteStatus(request: Details.SaveFavoriteStatus.Request) {
        
        if character?.isFavorite ?? false {
            
            worker?.deleteFavoriteCharactor(id: character?.id, completion: {[weak self] result in
                switch result {
                case .success(_):
                    let isFavorite = !(self?.character?.isFavorite ?? true)
                    self?.character?.isFavorite = isFavorite
                    self?.presenter?.presentFavoriteStatus(response: .init(character: self?.character))
                case .failure(let error):
                    self?.presenter?.presentErrorMessage(response: .init(error: error))
                }
            })
            
        } else {
            
            let favoriteCharacter = FavoriteCharacter(context: FavoriteCharacterRepository.shared.context)
            favoriteCharacter.id = Int64(character?.id ?? 0)
            favoriteCharacter.name = character?.name
            favoriteCharacter.image = character?.image?.pngData()
            
            worker?.createFavoriteCharactor(character: favoriteCharacter, completion: {[weak self] result in
                switch result {
                case .success(_):
                    let isFavorite = !(self?.character?.isFavorite ?? true)
                    self?.character?.isFavorite = isFavorite
                    self?.presenter?.presentFavoriteStatus(response: .init(character: self?.character))
                case .failure(let error):

                    self?.presenter?.presentErrorMessage(response: .init(error: error))
                }
            })
        }
    }
}
