//
//  FavoritesInteractorTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class FavoritesInteractorTests: XCTestCase {

    func testHandleFetchFavoriteCharacters() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let favoriteCharacter = FavoriteCharacter(context: FavoriteCharacterRepository.shared.context)
        favoriteCharacter.id = Int64(0)
        favoriteCharacter.name = "testName"
        favoriteCharacter.image = UIImage().pngData()
        
        let characters = [favoriteCharacter]
        
        // When
        worker.fetchFavoritesResponse = .success(characters)
        sut.handleFetchFavoriteCharacters(request: .init())
        
        // Then
        XCTAssertTrue(worker.invokedFetchFavorites)
        XCTAssertTrue(presenter.invokedPresentFavoriteCharacters)
        XCTAssertEqual(presenter.invokedPresentFavoriteCharactersParameters?.response.characters, characters)
    }
    
    func testHandleFetchFavoriteCharactersWhenFailure() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let favoriteCharacter = FavoriteCharacter(context: FavoriteCharacterRepository.shared.context)
        favoriteCharacter.id = Int64(0)
        favoriteCharacter.name = "testName"
        favoriteCharacter.image = UIImage().pngData()
        
        // When
        worker.fetchFavoritesResponse = .failure(.defaultError)
        sut.handleFetchFavoriteCharacters(request: .init())
        
        // Then
        XCTAssertTrue(worker.invokedFetchFavorites)
        XCTAssertTrue(presenter.invokedPresentErrorMessage)
        XCTAssertEqual(presenter.invokedPresentErrorMessageParameters?.response.error, .defaultError)
    }
    
    private func makeSUT() -> (sut: FavoritesInteractor, presenter: FavoritesPresenterSpy, worker: FavoritesStub) {
        let sut = FavoritesInteractor()
        let presenter = FavoritesPresenterSpy()
        let worker = FavoritesStub()
        
        sut.presenter = presenter
        sut.worker = worker
        
        return(sut, presenter, worker)
    }
}
