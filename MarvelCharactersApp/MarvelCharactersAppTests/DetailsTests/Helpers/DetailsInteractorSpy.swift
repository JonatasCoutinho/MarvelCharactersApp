//
//  DetailsInteractorSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class DetailsInteractorSpy: DetailsBusinessLogic, DetailsDataStore {

    var character: Character?

    var invokedHandleGetCharacterInfo = false
    var invokedHandleGetCharacterInfoCount = 0
    var invokedHandleGetCharacterInfoParameters: (request: Details.CharacterInfo.Request, Void)?
    var invokedHandleGetCharacterInfoParametersList = [(request: Details.CharacterInfo.Request, Void)]()

    func handleGetCharacterInfo(request: Details.CharacterInfo.Request) {
        invokedHandleGetCharacterInfo = true
        invokedHandleGetCharacterInfoCount += 1
        invokedHandleGetCharacterInfoParameters = (request, ())
        invokedHandleGetCharacterInfoParametersList.append((request, ()))
    }

    var invokedHandleSaveFavoriteStatus = false
    var invokedHandleSaveFavoriteStatusCount = 0
    var invokedHandleSaveFavoriteStatusParameters: (request: Details.SaveFavoriteStatus.Request, Void)?
    var invokedHandleSaveFavoriteStatusParametersList = [(request: Details.SaveFavoriteStatus.Request, Void)]()

    func handleSaveFavoriteStatus(request: Details.SaveFavoriteStatus.Request) {
        invokedHandleSaveFavoriteStatus = true
        invokedHandleSaveFavoriteStatusCount += 1
        invokedHandleSaveFavoriteStatusParameters = (request, ())
        invokedHandleSaveFavoriteStatusParametersList.append((request, ()))
    }
}
