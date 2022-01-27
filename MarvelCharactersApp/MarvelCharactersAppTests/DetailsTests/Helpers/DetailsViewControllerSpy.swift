//
//  DetailsViewControllerSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class DetailsViewControllerSpy: DetailsDisplayLogic {
    
    var invokedDisplayCharacterInfo = false
    var invokedDisplayCharacterInfoCount = 0
    var invokedDisplayCharacterInfoParameters: (viewModel: Details.CharacterInfo.ViewModel, Void)?
    var invokedDisplayCharacterInfoParametersList = [(viewModel: Details.CharacterInfo.ViewModel, Void)]()

    func displayCharacterInfo(viewModel: Details.CharacterInfo.ViewModel) {
        invokedDisplayCharacterInfo = true
        invokedDisplayCharacterInfoCount += 1
        invokedDisplayCharacterInfoParameters = (viewModel, ())
        invokedDisplayCharacterInfoParametersList.append((viewModel, ()))
    }

    var invokedDisplayFavoriteStatus = false
    var invokedDisplayFavoriteStatusCount = 0
    var invokedDisplayFavoriteStatusParameters: (viewModel: Details.SaveFavoriteStatus.ViewModel, Void)?
    var invokedDisplayFavoriteStatusParametersList = [(viewModel: Details.SaveFavoriteStatus.ViewModel, Void)]()

    func displayFavoriteStatus(viewModel: Details.SaveFavoriteStatus.ViewModel) {
        invokedDisplayFavoriteStatus = true
        invokedDisplayFavoriteStatusCount += 1
        invokedDisplayFavoriteStatusParameters = (viewModel, ())
        invokedDisplayFavoriteStatusParametersList.append((viewModel, ()))
    }
    
    var invokedDisplayErrorMessage = false
    var invokedDisplayErrorMessageCount = 0
    var invokedDisplayErrorMessageParameters: (viewModel: Details.ErrorMessage.ViewModel, Void)?
    var invokedDisplayErrorMessageParametersList = [(viewModel: Details.ErrorMessage.ViewModel, Void)]()

    func displayErrorMessage(viewModel: Details.ErrorMessage.ViewModel) {
        invokedDisplayErrorMessage = true
        invokedDisplayErrorMessageCount += 1
        invokedDisplayErrorMessageParameters = (viewModel, ())
        invokedDisplayErrorMessageParametersList.append((viewModel, ()))
    }
}

