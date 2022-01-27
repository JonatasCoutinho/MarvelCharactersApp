//
//  FavoritesViewControllerTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class FavoritesViewControllerTests: XCTestCase {
    
    func testInteractorCallLoadView() {
        // Given
        let (sut, interactor, _) = makeSUT()
        let window = UIWindow()
        
        // When
        window.addSubview(sut.view)
        
        // Then
        XCTAssertTrue(interactor.invokedHandleFetchFavoriteCharacters)
    }
    
    func testSetupUI() {
        // Given
        let (sut, _, _) = makeSUT()
        let window = UIWindow()

        // When
        window.addSubview(sut.view)
        sut.setupUI()

        // Then
        XCTAssertEqual(sut.charactersTableView.superview, sut.view)
    }
    
    func testInteractorCallRefreshWeatherData() {
        // Given
        let (sut, interactor, _) = makeSUT()
        
        // When
        sut.refreshWeatherData(sender: .init())
        
        // Then
        XCTAssertTrue(interactor.invokedHandleFetchFavoriteCharacters)
    }
    
    func testDisplayFavoriteCharacters() {
        // Given
        let (sut, _, _) = makeSUT()
        
        let favoriteCharacter = FavoriteCharacter(context: FavoriteCharacterRepository.shared.context)
        favoriteCharacter.id = Int64(0)
        favoriteCharacter.name = "testName"
        favoriteCharacter.image = UIImage().pngData()
        
        let characters: [FavoriteCharacter] = [favoriteCharacter]

        DispatchQueue.main.async{
            // When
            sut.displayFavoriteCharacters(viewModel: .init(characters: characters))

            // Then
            XCTAssertEqual(sut.characters, characters)
            XCTAssertEqual(sut.charactersTableView.numberOfRows(inSection: 0), sut.characters.count)
        }
    }

    private func makeSUT() -> (sut: FavoritesViewController, interactor: FavoritesInteractorSpy, router: FavoritesRouterSpy) {
        let interactor = FavoritesInteractorSpy()
        let router = FavoritesRouterSpy()
        let sut = FavoritesViewController()
        sut.interactor = interactor
        sut.router = router
        
        return(sut, interactor, router)
    }
}

