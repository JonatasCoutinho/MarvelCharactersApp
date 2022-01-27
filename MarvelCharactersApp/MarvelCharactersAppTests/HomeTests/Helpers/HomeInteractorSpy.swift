//
//  HomeInteractorSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class HomeInteractorSpy: HomeBusinessLogic, HomeDataStore {

    var characters: [Character]?

    var invokedHandleFetchCharactersList = false
    var invokedHandleFetchCharactersListCount = 0
    var invokedHandleFetchCharactersListParameters: (request: Home.FetchCharacters.Request, Void)?
    var invokedHandleFetchCharactersListParametersList = [(request: Home.FetchCharacters.Request, Void)]()

    func handleFetchCharactersList(request: Home.FetchCharacters.Request) {
        invokedHandleFetchCharactersList = true
        invokedHandleFetchCharactersListCount += 1
        invokedHandleFetchCharactersListParameters = (request, ())
        invokedHandleFetchCharactersListParametersList.append((request, ()))
    }

    var invokedHandleFilterCharacters = false
    var invokedHandleFilterCharactersCount = 0
    var invokedHandleFilterCharactersParameters: (request: Home.FilterCharacters.Request, Void)?
    var invokedHandleFilterCharactersParametersList = [(request: Home.FilterCharacters.Request, Void)]()

    func handleFilterCharacters(request: Home.FilterCharacters.Request) {
        invokedHandleFilterCharacters = true
        invokedHandleFilterCharactersCount += 1
        invokedHandleFilterCharactersParameters = (request, ())
        invokedHandleFilterCharactersParametersList.append((request, ()))
    }

    var invokedHandleUpdateFavoriteCharacter = false
    var invokedHandleUpdateFavoriteCharacterCount = 0
    var invokedHandleUpdateFavoriteCharacterParameters: (request: Home.UpdateCharacter.Request, Void)?
    var invokedHandleUpdateFavoriteCharacterParametersList = [(request: Home.UpdateCharacter.Request, Void)]()

    func handleUpdateFavoriteCharacter(request: Home.UpdateCharacter.Request) {
        invokedHandleUpdateFavoriteCharacter = true
        invokedHandleUpdateFavoriteCharacterCount += 1
        invokedHandleUpdateFavoriteCharacterParameters = (request, ())
        invokedHandleUpdateFavoriteCharacterParametersList.append((request, ()))
    }

    var invokedHandleSaveFavoriteStatus = false
    var invokedHandleSaveFavoriteStatusCount = 0
    var invokedHandleSaveFavoriteStatusParameters: (request: Home.SaveFavoriteStatus.Request, Void)?
    var invokedHandleSaveFavoriteStatusParametersList = [(request: Home.SaveFavoriteStatus.Request, Void)]()

    func handleSaveFavoriteStatus(request: Home.SaveFavoriteStatus.Request) {
        invokedHandleSaveFavoriteStatus = true
        invokedHandleSaveFavoriteStatusCount += 1
        invokedHandleSaveFavoriteStatusParameters = (request, ())
        invokedHandleSaveFavoriteStatusParametersList.append((request, ()))
    }
}
