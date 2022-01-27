//
//  FavoritesInteractor.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol FavoritesBusinessLogic {
    func handleFetchFavoriteCharacters(request: Favorites.FetchFavorites.Request)
}

protocol FavoritesDataStore {
    
}

class FavoritesInteractor: FavoritesDataStore {
  var presenter: FavoritesPresentationLogic?
  var worker: FavoritesWorkerLogic?
}

extension FavoritesInteractor: FavoritesBusinessLogic {
    func handleFetchFavoriteCharacters(request: Favorites.FetchFavorites.Request) {
        self.worker?.fetchFavorites(completion: { [weak self] result in
            switch result {
            case .success(let characters):
                let sortedCharactors = characters.sorted(by: { $0.name ?? "" < $1.name ?? ""})
                self?.presenter?.presentFavoriteCharacters(response: .init(characters: sortedCharactors))
            case .failure(let error):
                self?.presenter?.presentErrorMessage(response: .init(error: error))
            }
            
        })
    }
}
