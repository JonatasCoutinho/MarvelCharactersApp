//
//  FavoritesInteractorSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class FavoritesInteractorSpy: FavoritesBusinessLogic, FavoritesDataStore {

    var invokedHandleFetchFavoriteCharacters = false
    var invokedHandleFetchFavoriteCharactersCount = 0
    var invokedHandleFetchFavoriteCharactersParameters: (request: Favorites.FetchFavorites.Request, Void)?
    var invokedHandleFetchFavoriteCharactersParametersList = [(request: Favorites.FetchFavorites.Request, Void)]()

    func handleFetchFavoriteCharacters(request: Favorites.FetchFavorites.Request) {
        invokedHandleFetchFavoriteCharacters = true
        invokedHandleFetchFavoriteCharactersCount += 1
        invokedHandleFetchFavoriteCharactersParameters = (request, ())
        invokedHandleFetchFavoriteCharactersParametersList.append((request, ()))
    }
}
