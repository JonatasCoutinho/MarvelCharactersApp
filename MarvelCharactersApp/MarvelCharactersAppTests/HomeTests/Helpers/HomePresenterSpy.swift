//
//  HomePresenterSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class HomePresenterSpy: HomePresentationLogic {

    var invokedPresentCharacters = false
    var invokedPresentCharactersCount = 0
    var invokedPresentCharactersParameters: (response: Home.FetchCharacters.Response, Void)?
    var invokedPresentCharactersParametersList = [(response: Home.FetchCharacters.Response, Void)]()

    func presentCharacters(response: Home.FetchCharacters.Response) {
        invokedPresentCharacters = true
        invokedPresentCharactersCount += 1
        invokedPresentCharactersParameters = (response, ())
        invokedPresentCharactersParametersList.append((response, ()))
    }

    var invokedPresentFilterCharacters = false
    var invokedPresentFilterCharactersCount = 0
    var invokedPresentFilterCharactersParameters: (response: Home.FetchCharacters.Response, Void)?
    var invokedPresentFilterCharactersParametersList = [(response: Home.FetchCharacters.Response, Void)]()

    func presentFilterCharacters(response: Home.FetchCharacters.Response) {
        invokedPresentFilterCharacters = true
        invokedPresentFilterCharactersCount += 1
        invokedPresentFilterCharactersParameters = (response, ())
        invokedPresentFilterCharactersParametersList.append((response, ()))
    }

    var invokedPresentUpdateFavoriteCharacter = false
    var invokedPresentUpdateFavoriteCharacterCount = 0
    var invokedPresentUpdateFavoriteCharacterParameters: (response: Home.UpdateCharacter.Response, Void)?
    var invokedPresentUpdateFavoriteCharacterParametersList = [(response: Home.UpdateCharacter.Response, Void)]()

    func presentUpdateFavoriteCharacter(response: Home.UpdateCharacter.Response) {
        invokedPresentUpdateFavoriteCharacter = true
        invokedPresentUpdateFavoriteCharacterCount += 1
        invokedPresentUpdateFavoriteCharacterParameters = (response, ())
        invokedPresentUpdateFavoriteCharacterParametersList.append((response, ()))
    }

    var invokedPresentFavoriteStatus = false
    var invokedPresentFavoriteStatusCount = 0
    var invokedPresentFavoriteStatusParameters: (response: Home.SaveFavoriteStatus.Response, Void)?
    var invokedPresentFavoriteStatusParametersList = [(response: Home.SaveFavoriteStatus.Response, Void)]()

    func presentFavoriteStatus(response: Home.SaveFavoriteStatus.Response) {
        invokedPresentFavoriteStatus = true
        invokedPresentFavoriteStatusCount += 1
        invokedPresentFavoriteStatusParameters = (response, ())
        invokedPresentFavoriteStatusParametersList.append((response, ()))
    }

    var invokedPresentErrorMessage = false
    var invokedPresentErrorMessageCount = 0
    var invokedPresentErrorMessageParameters: (response: Home.ErrorMessage.Response, Void)?
    var invokedPresentErrorMessageParametersList = [(response: Home.ErrorMessage.Response, Void)]()

    func presentErrorMessage(response: Home.ErrorMessage.Response) {
        invokedPresentErrorMessage = true
        invokedPresentErrorMessageCount += 1
        invokedPresentErrorMessageParameters = (response, ())
        invokedPresentErrorMessageParametersList.append((response, ()))
    }
}
