//
//  MainNavigationController.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 27/01/22.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        let appearance = UINavigationBarAppearance()
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.red]
        self.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.red]
        self.navigationItem.standardAppearance = appearance
        self.navigationItem.scrollEdgeAppearance = appearance
        
        self.navigationBar.barTintColor = .black
        self.navigationBar.backgroundColor = .black
        self.navigationBar.tintColor = .marvelRed
        self.navigationBar.prefersLargeTitles = true
    }
}
