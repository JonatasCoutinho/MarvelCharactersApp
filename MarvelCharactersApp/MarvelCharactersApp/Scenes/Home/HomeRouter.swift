//
//  HomeRouter.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol HomeRoutingLogic {
    func routeToDetailScreen(characterID: Int)
}

protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: HomeDataPassing {
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
}

// MARK: Routing

extension HomeRouter: HomeRoutingLogic {
    func routeToDetailScreen(characterID: Int) {
        let detailVC = DetailsViewController()
        
        detailVC.delegate = viewController
        if var detailDataStore = detailVC.router?.dataStore, let homeDataStore = self.dataStore {
            passDataToDetailScreen(source: homeDataStore, destination: &detailDataStore, characterID: characterID)
        }
        
        viewController?.navigationController?.pushViewController(detailVC, animated: false)
    }
}

// MARK: Passing data

private extension HomeRouter {
    func passDataToDetailScreen(source: HomeDataStore, destination: inout DetailsDataStore, characterID: Int) {
        guard let character = source.characters?.filter({ $0.id == characterID }).first else {
            return
        }
        
        destination.character = character
    }
}
