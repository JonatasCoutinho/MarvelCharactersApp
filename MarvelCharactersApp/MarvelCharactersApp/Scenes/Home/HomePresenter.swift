//
//  HomePresenter.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol HomePresentationLogic {
    func presentCharacters(response: Home.FetchCharacters.Response)
    func presentFilterCharacters(response: Home.FetchCharacters.Response)
    func presentUpdateFavoriteCharacter(response: Home.UpdateCharacter.Response)
    func presentFavoriteStatus(response: Home.SaveFavoriteStatus.Response)
    func presentErrorMessage(response: Home.ErrorMessage.Response)
}

class HomePresenter {
    weak var viewController: HomeDisplayLogic?
}

extension HomePresenter: HomePresentationLogic {
    
    func presentCharacters(response: Home.FetchCharacters.Response) {
        viewController?.displayCharacters(viewModel: .init(characters: response.characters))
    }
    
    func presentFilterCharacters(response: Home.FetchCharacters.Response) {
        viewController?.displayFilterCharacters(viewModel: .init(characters: response.characters))
    }
    
    func presentUpdateFavoriteCharacter(response: Home.UpdateCharacter.Response) {
        viewController?.displayUpdateFavoriteCharacter(viewModel: .init(characters: response.characters))
    }
    
    func presentFavoriteStatus(response: Home.SaveFavoriteStatus.Response) {
        viewController?.displayFavoriteStatus(viewModel: .init(characters: response.characters))
    }
    
    func presentErrorMessage(response: Home.ErrorMessage.Response) {
        viewController?.displayErrorMessage(viewModel: .init(message: response.error.message))
    }
}
