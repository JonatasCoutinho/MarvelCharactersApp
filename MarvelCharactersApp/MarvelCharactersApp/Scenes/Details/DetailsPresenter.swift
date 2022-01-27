//
//  DetailsPresenter.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol DetailsPresentationLogic {
    func presentCharacterInfo(response: Details.CharacterInfo.Response)
    func presentFavoriteStatus(response: Details.SaveFavoriteStatus.Response)
    func presentErrorMessage(response: Details.ErrorMessage.Response)
}

class DetailsPresenter {
    weak var viewController: DetailsDisplayLogic?
    
}

extension DetailsPresenter: DetailsPresentationLogic {
    func presentCharacterInfo(response: Details.CharacterInfo.Response) {
        
        let name = (response.character?.name?.isEmpty ?? true) ? "Unavailable Name" : response.character?.name
        let detail = (response.character?.description?.isEmpty ?? true) ? "Unavailable Description" : response.character?.description
        let image = response.character?.image ?? UIImage(systemName: "clear")!
        
        viewController?.displayCharacterInfo(viewModel: .init(character: response.character, name: name, detail: detail, image: image))
    }
    
    func presentFavoriteStatus(response: Details.SaveFavoriteStatus.Response) {
        
        let name = (response.character?.name?.isEmpty ?? true) ? "Unavailable Name" : response.character?.name
        let detail = (response.character?.description?.isEmpty ?? true) ? "Unavailable Description" : response.character?.description
        let image = response.character?.image ?? UIImage(systemName: "clear")!
        
        viewController?.displayFavoriteStatus(viewModel: .init(character: response.character, name: name, detail: detail, image: image))
    }
    
    func presentErrorMessage(response: Details.ErrorMessage.Response) {
        viewController?.displayErrorMessage(viewModel: .init(message: response.error.message))
    }
}
