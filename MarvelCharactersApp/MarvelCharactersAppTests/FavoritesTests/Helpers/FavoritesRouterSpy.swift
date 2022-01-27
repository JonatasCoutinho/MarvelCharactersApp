//
//  FavoritesRouterSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class FavoritesRouterSpy: FavoritesRoutingLogic, FavoritesDataPassing {
    var dataStore: FavoritesDataStore?
}
