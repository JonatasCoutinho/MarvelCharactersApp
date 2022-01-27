//
//  FavoritesViewControllerSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class FavoritesViewControllerSpy: FavoritesDisplayLogic {
    
    var invokedDisplayFavoriteCharacters = false
    var invokedDisplayFavoriteCharactersCount = 0
    var invokedDisplayFavoriteCharactersParameters: (viewModel: Favorites.FetchFavorites.ViewModel, Void)?
    var invokedDisplayFavoriteCharactersParametersList = [(viewModel: Favorites.FetchFavorites.ViewModel, Void)]()

    func displayFavoriteCharacters(viewModel: Favorites.FetchFavorites.ViewModel) {
        invokedDisplayFavoriteCharacters = true
        invokedDisplayFavoriteCharactersCount += 1
        invokedDisplayFavoriteCharactersParameters = (viewModel, ())
        invokedDisplayFavoriteCharactersParametersList.append((viewModel, ()))
    }
    
    var invokedDisplayErrorMessage = false
    var invokedDisplayErrorMessageCount = 0
    var invokedDisplayErrorMessageParameters: (viewModel: Favorites.ErrorMessage.ViewModel, Void)?
    var invokedDisplayErrorMessageParametersList = [(viewModel: Favorites.ErrorMessage.ViewModel, Void)]()

    func displayErrorMessage(viewModel: Favorites.ErrorMessage.ViewModel) {
        invokedDisplayErrorMessage = true
        invokedDisplayErrorMessageCount += 1
        invokedDisplayErrorMessageParameters = (viewModel, ())
        invokedDisplayErrorMessageParametersList.append((viewModel, ()))
    }
}

