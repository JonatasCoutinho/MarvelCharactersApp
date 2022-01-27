//
//  HomeViewControllerSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class HomeViewControllerSpy: HomeDisplayLogic {

    var invokedDisplayCharacters = false
    var invokedDisplayCharactersCount = 0
    var invokedDisplayCharactersParameters: (viewModel: Home.FetchCharacters.ViewModel, Void)?
    var invokedDisplayCharactersParametersList = [(viewModel: Home.FetchCharacters.ViewModel, Void)]()

    func displayCharacters(viewModel: Home.FetchCharacters.ViewModel) {
        invokedDisplayCharacters = true
        invokedDisplayCharactersCount += 1
        invokedDisplayCharactersParameters = (viewModel, ())
        invokedDisplayCharactersParametersList.append((viewModel, ()))
    }

    var invokedDisplayFilterCharacters = false
    var invokedDisplayFilterCharactersCount = 0
    var invokedDisplayFilterCharactersParameters: (viewModel: Home.FetchCharacters.ViewModel, Void)?
    var invokedDisplayFilterCharactersParametersList = [(viewModel: Home.FetchCharacters.ViewModel, Void)]()

    func displayFilterCharacters(viewModel: Home.FetchCharacters.ViewModel) {
        invokedDisplayFilterCharacters = true
        invokedDisplayFilterCharactersCount += 1
        invokedDisplayFilterCharactersParameters = (viewModel, ())
        invokedDisplayFilterCharactersParametersList.append((viewModel, ()))
    }

    var invokedDisplayUpdateFavoriteCharacter = false
    var invokedDisplayUpdateFavoriteCharacterCount = 0
    var invokedDisplayUpdateFavoriteCharacterParameters: (viewModel: Home.UpdateCharacter.ViewModel, Void)?
    var invokedDisplayUpdateFavoriteCharacterParametersList = [(viewModel: Home.UpdateCharacter.ViewModel, Void)]()

    func displayUpdateFavoriteCharacter(viewModel: Home.UpdateCharacter.ViewModel) {
        invokedDisplayUpdateFavoriteCharacter = true
        invokedDisplayUpdateFavoriteCharacterCount += 1
        invokedDisplayUpdateFavoriteCharacterParameters = (viewModel, ())
        invokedDisplayUpdateFavoriteCharacterParametersList.append((viewModel, ()))
    }

    var invokedDisplayFavoriteStatus = false
    var invokedDisplayFavoriteStatusCount = 0
    var invokedDisplayFavoriteStatusParameters: (viewModel: Home.SaveFavoriteStatus.ViewModel, Void)?
    var invokedDisplayFavoriteStatusParametersList = [(viewModel: Home.SaveFavoriteStatus.ViewModel, Void)]()

    func displayFavoriteStatus(viewModel: Home.SaveFavoriteStatus.ViewModel) {
        invokedDisplayFavoriteStatus = true
        invokedDisplayFavoriteStatusCount += 1
        invokedDisplayFavoriteStatusParameters = (viewModel, ())
        invokedDisplayFavoriteStatusParametersList.append((viewModel, ()))
    }

    var invokedDisplayErrorMessage = false
    var invokedDisplayErrorMessageCount = 0
    var invokedDisplayErrorMessageParameters: (viewModel: Home.ErrorMessage.ViewModel, Void)?
    var invokedDisplayErrorMessageParametersList = [(viewModel: Home.ErrorMessage.ViewModel, Void)]()

    func displayErrorMessage(viewModel: Home.ErrorMessage.ViewModel) {
        invokedDisplayErrorMessage = true
        invokedDisplayErrorMessageCount += 1
        invokedDisplayErrorMessageParameters = (viewModel, ())
        invokedDisplayErrorMessageParametersList.append((viewModel, ()))
    }
}

