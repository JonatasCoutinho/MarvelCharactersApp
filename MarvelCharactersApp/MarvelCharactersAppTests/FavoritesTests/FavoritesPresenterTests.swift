//
//  FavoritesPresenterTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class FavoritesPresenterTests: XCTestCase {
    
    func testPresentFavoriteCharacters() {
        // Given
        let (sut, vc) = makeSUT()
        
        let favoriteCharacter = FavoriteCharacter(context: FavoriteCharacterRepository.shared.context)
        favoriteCharacter.id = Int64(0)
        favoriteCharacter.name = "testName"
        favoriteCharacter.image = UIImage().pngData()
        
        let characters: [FavoriteCharacter] = [favoriteCharacter]
        
        // When
        sut.presentFavoriteCharacters(response: .init(characters: characters))
        
        // Then
        XCTAssertTrue(vc.invokedDisplayFavoriteCharacters)
        XCTAssertEqual(vc.invokedDisplayFavoriteCharactersParameters?.viewModel.characters, characters)
    }
    
    func testPresentErrorMessage() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Favorites.ErrorMessage.Response(error: .defaultError)

        // When
        sut.presentErrorMessage(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayErrorMessage)
        XCTAssertEqual(vc.invokedDisplayErrorMessageParameters?.viewModel.message, response.error.message)
    }
    
    private func makeSUT() -> (sut: FavoritesPresenter, vc: FavoritesViewControllerSpy) {
        let sut = FavoritesPresenter()
        let vc = FavoritesViewControllerSpy()
        
        sut.viewController = vc
        
        return(sut, vc)
    }
}
