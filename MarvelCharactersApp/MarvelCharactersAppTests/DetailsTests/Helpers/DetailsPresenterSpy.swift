//
//  DetailsPresenterSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class DetailsPresenterSpy: DetailsPresentationLogic {
    
    var invokedPresentCharacterInfo = false
    var invokedPresentCharacterInfoCount = 0
    var invokedPresentCharacterInfoParameters: (response: Details.CharacterInfo.Response, Void)?
    var invokedPresentCharacterInfoParametersList = [(response: Details.CharacterInfo.Response, Void)]()

    func presentCharacterInfo(response: Details.CharacterInfo.Response) {
        invokedPresentCharacterInfo = true
        invokedPresentCharacterInfoCount += 1
        invokedPresentCharacterInfoParameters = (response, ())
        invokedPresentCharacterInfoParametersList.append((response, ()))
    }

    var invokedPresentFavoriteStatus = false
    var invokedPresentFavoriteStatusCount = 0
    var invokedPresentFavoriteStatusParameters: (response: Details.SaveFavoriteStatus.Response, Void)?
    var invokedPresentFavoriteStatusParametersList = [(response: Details.SaveFavoriteStatus.Response, Void)]()

    func presentFavoriteStatus(response: Details.SaveFavoriteStatus.Response) {
        invokedPresentFavoriteStatus = true
        invokedPresentFavoriteStatusCount += 1
        invokedPresentFavoriteStatusParameters = (response, ())
        invokedPresentFavoriteStatusParametersList.append((response, ()))
    }
    
    var invokedPresentErrorMessage = false
    var invokedPresentErrorMessageCount = 0
    var invokedPresentErrorMessageParameters: (response: Details.ErrorMessage.Response, Void)?
    var invokedPresentErrorMessageParametersList = [(response: Details.ErrorMessage.Response, Void)]()

    func presentErrorMessage(response: Details.ErrorMessage.Response) {
        invokedPresentErrorMessage = true
        invokedPresentErrorMessageCount += 1
        invokedPresentErrorMessageParameters = (response, ())
        invokedPresentErrorMessageParametersList.append((response, ()))
    }
}
