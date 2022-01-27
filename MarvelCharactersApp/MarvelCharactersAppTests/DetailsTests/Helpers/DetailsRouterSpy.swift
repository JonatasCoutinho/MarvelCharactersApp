//
//  DetailsRouterSpy.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp

class DetailsRouterSpy: DetailsRoutingLogic, DetailsDataPassing{
    var dataStore: DetailsDataStore?
}
