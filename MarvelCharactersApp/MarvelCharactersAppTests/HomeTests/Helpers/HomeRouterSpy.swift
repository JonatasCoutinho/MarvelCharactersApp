//
//  HomeRouterSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class HomeRouterSpy: HomeRoutingLogic, HomeDataPassing {

    var dataStore: HomeDataStore?
    
    var invokedRouteToDetailScreen = false
    var invokedRouteToDetailScreenCount = 0
    var invokedRouteToDetailScreenParameters: (characterID: Int, Void)?
    var invokedRouteToDetailScreenParametersList = [(characterID: Int, Void)]()

    func routeToDetailScreen(characterID: Int) {
        invokedRouteToDetailScreen = true
        invokedRouteToDetailScreenCount += 1
        invokedRouteToDetailScreenParameters = (characterID, ())
        invokedRouteToDetailScreenParametersList.append((characterID, ()))
    }
}
