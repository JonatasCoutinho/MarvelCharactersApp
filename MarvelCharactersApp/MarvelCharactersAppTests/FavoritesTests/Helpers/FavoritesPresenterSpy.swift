//
//  FavoritesPresenterSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class FavoritesPresenterSpy: FavoritesPresentationLogic {

    var invokedPresentFavoriteCharacters = false
    var invokedPresentFavoriteCharactersCount = 0
    var invokedPresentFavoriteCharactersParameters: (response: Favorites.FetchFavorites.Response, Void)?
    var invokedPresentFavoriteCharactersParametersList = [(response: Favorites.FetchFavorites.Response, Void)]()

    func presentFavoriteCharacters(response: Favorites.FetchFavorites.Response) {
        invokedPresentFavoriteCharacters = true
        invokedPresentFavoriteCharactersCount += 1
        invokedPresentFavoriteCharactersParameters = (response, ())
        invokedPresentFavoriteCharactersParametersList.append((response, ()))
    }
    
    var invokedPresentErrorMessage = false
    var invokedPresentErrorMessageCount = 0
    var invokedPresentErrorMessageParameters: (response: Favorites.ErrorMessage.Response, Void)?
    var invokedPresentErrorMessageParametersList = [(response: Favorites.ErrorMessage.Response, Void)]()

    func presentErrorMessage(response: Favorites.ErrorMessage.Response) {
        invokedPresentErrorMessage = true
        invokedPresentErrorMessageCount += 1
        invokedPresentErrorMessageParameters = (response, ())
        invokedPresentErrorMessageParametersList.append((response, ()))
    }
}
