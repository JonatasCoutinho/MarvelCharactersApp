//
//  DetailsRouter.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 20/01/22.
//

import UIKit

protocol DetailsRoutingLogic {
    
}

protocol DetailsDataPassing {
    var dataStore: DetailsDataStore? { get }
}

class DetailsRouter: NSObject, DetailsRoutingLogic, DetailsDataPassing {
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    
}
