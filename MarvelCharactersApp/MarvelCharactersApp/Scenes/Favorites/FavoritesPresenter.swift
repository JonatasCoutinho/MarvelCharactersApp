//
//  FavoritesPresenter.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol FavoritesPresentationLogic {
    func presentFavoriteCharacters(response: Favorites.FetchFavorites.Response)
    func presentErrorMessage(response: Favorites.ErrorMessage.Response) 
}

class FavoritesPresenter {
  weak var viewController: FavoritesDisplayLogic?
    
}

extension FavoritesPresenter: FavoritesPresentationLogic {
    func presentFavoriteCharacters(response: Favorites.FetchFavorites.Response) {
        viewController?.displayFavoriteCharacters(viewModel: .init(characters: response.characters))
    }
    
    func presentErrorMessage(response: Favorites.ErrorMessage.Response) {
        viewController?.displayErrorMessage(viewModel: .init(message: response.error.message))
    }
}
