//
//  FavoritesRouter.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol FavoritesRoutingLogic {
    
}

protocol FavoritesDataPassing {
    var dataStore: FavoritesDataStore? { get }
}

class FavoritesRouter: FavoritesRoutingLogic, FavoritesDataPassing {
    weak var viewController: FavoritesViewController?
    var dataStore: FavoritesDataStore?
    
}
