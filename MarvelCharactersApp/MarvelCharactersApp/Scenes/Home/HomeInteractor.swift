//
//  HomeInteractor.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol HomeBusinessLogic {
    func handleFetchCharactersList(request: Home.FetchCharacters.Request)
    func handleFilterCharacters(request: Home.FilterCharacters.Request)
    func handleUpdateFavoriteCharacter(request: Home.UpdateCharacter.Request)
    func handleSaveFavoriteStatus(request: Home.SaveFavoriteStatus.Request)
}

protocol HomeDataStore {
    var characters: [Character]? { get set }
}

class HomeInteractor: HomeDataStore {
    var presenter: HomePresentationLogic?
    var worker: HomeWorkerLogic?
    
    var characters: [Character]?
}

extension HomeInteractor: HomeBusinessLogic {
    func handleFetchCharactersList(request: Home.FetchCharacters.Request) {        worker?.fetchCharacters(completion: { [weak self] result in
        
            switch result {
            case .success(let result):
                
                self?.worker?.fetchCharactersImage(characters: result, completion: { charactersWithImage in
                    
                    var charactersWithFavorites = charactersWithImage
                    
                    self?.worker?.fetchFavoritesIds(completion: { result in
                        switch result {
                        case .success(let ids):
                            for id in ids {
                                guard let index = charactersWithImage.firstIndex(where: { $0.id == id}) else {
                                    continue
                                }
                                
                                charactersWithFavorites[index].isFavorite = true
                            }
                            
                            self?.characters = charactersWithFavorites
                            self?.presenter?.presentCharacters(response: .init(characters: charactersWithFavorites))
                            
                        case .failure(let error):
                            self?.presenter?.presentErrorMessage(response: .init(error: error))
                        }
                    })
                })
                
            case .failure(let error):
                self?.presenter?.presentErrorMessage(response: .init(error: error))
            }
        })
    }
    
    func handleFilterCharacters(request: Home.FilterCharacters.Request) {
        
        var filtredCharacters: [Character] = []
        
        if request.searchText?.isEmpty ?? true {
            filtredCharacters = characters ?? []
            
        }else {
            filtredCharacters = characters?.filter({ character -> Bool in
                return character.name!.lowercased().contains((request.searchText ?? "").lowercased())
            }) ?? []
        }
        presenter?.presentFilterCharacters(response: .init(characters: filtredCharacters))
    }
    
    func handleUpdateFavoriteCharacter(request: Home.UpdateCharacter.Request) {
        
        self.setFavoriteCharacter(characterID: request.character?.id, isFavorite: request.character?.isFavorite)
        
        presenter?.presentUpdateFavoriteCharacter(response: .init(characters: characters))
    }
    
    func handleSaveFavoriteStatus(request: Home.SaveFavoriteStatus.Request) {
        
        if request.character?.isFavorite ?? true {
            
            let favoriteCharacter = FavoriteCharacter(context: FavoriteCharacterRepository.shared.context)
            favoriteCharacter.id = Int64(request.character?.id ?? 0)
            favoriteCharacter.name = request.character?.name
            favoriteCharacter.image = request.character?.image?.pngData()
            
            worker?.createFavoriteCharactor(character: favoriteCharacter, completion: {[weak self] result in
                switch result {
                case .success(_):
                    self?.setFavoriteCharacter(characterID: request.character?.id, isFavorite: request.character?.isFavorite)
                    self?.presenter?.presentFavoriteStatus(response: .init(characters: self?.characters))
                case .failure(let error):
                    self?.presenter?.presentErrorMessage(response: .init(error: error))
                }
            })
        } else {
            
            worker?.deleteFavoriteCharactor(id: request.character?.id, completion: {[weak self] result in
                switch result {
                case .success(_):
                    self?.setFavoriteCharacter(characterID: request.character?.id, isFavorite: request.character?.isFavorite)
                    self?.presenter?.presentFavoriteStatus(response: .init(characters: self?.characters))
                case .failure(let error):
                    self?.presenter?.presentErrorMessage(response: .init(error: error))
                }
            })
        }
    }
}

private extension HomeInteractor {
    func setFavoriteCharacter(characterID: Int?, isFavorite: Bool?) {
        guard let index = characters?.firstIndex(where: { $0.id == characterID} ) else {
            return
        }
        characters?[index].isFavorite = isFavorite
    }
}
