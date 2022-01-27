//
//  MainTabBarController.swift
//  MarvelCharactersApp
//
//  Created by Jonatas Coutinho de Faria on 22/01/22.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = HomeViewController()
        let favoritesVC = FavoritesViewController()
        homeVC.title = "Home"
        favoritesVC.title = "Favorites"
        
        let homeNC = MainNavigationController(rootViewController: homeVC)
        let favoritesNC = MainNavigationController(rootViewController: favoritesVC)
        
        self.setViewControllers([homeNC, favoritesNC], animated: true)
        
        guard let items = self.tabBar.items else { return }
        let images = [UIImage(systemName: "house.fill"), UIImage(systemName: "star.fill")]
        
        for (item, image) in zip(items, images) {
            item.image = image
        }
        
        self.tabBar.tintColor = .marvelRed
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = .lightGray
    }
}
