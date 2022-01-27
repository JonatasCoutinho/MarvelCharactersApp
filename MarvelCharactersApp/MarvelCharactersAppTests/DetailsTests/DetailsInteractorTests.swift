//
//  DetailsInteractorTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class DetailsInteractorTests: XCTestCase {

    func tesHandleGetCharacterInfo() {
        // Given
        let (sut, presenter, _) = makeSUT()
        
        let characters = Character(id: 0, name: "testName", description: "testDescription", image: nil, isFavorite: false)
        
        // When
        sut.character = characters
        sut.handleGetCharacterInfo(request: .init())
        
        // Then
        XCTAssertTrue(presenter.invokedPresentCharacterInfo)
        XCTAssertEqual(presenter.invokedPresentCharacterInfoParameters?.response.character, sut.character)
    }
    
    func testhandleSaveFavoriteStatusWhenCharacterIsFavorite() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        sut.character = character
        worker.deleteFavoriteCharactorResponse = .success(true)
        sut.handleSaveFavoriteStatus(request: .init())
        
        // Then
        XCTAssertTrue(worker.invokedDeleteFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentFavoriteStatus)
        XCTAssertEqual(sut.character, updatedCharacter)
        XCTAssertEqual(updatedCharacter, presenter.invokedPresentFavoriteStatusParameters?.response.character)
    }
    
    func testhandleSaveFavoriteStatusWhenCharacterIsNotFavorite() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        
        // When
        sut.character = character
        worker.createFavoriteCharactorResponse = .success(true)
        sut.handleSaveFavoriteStatus(request: .init())
        
        // Then
        XCTAssertTrue(worker.invokedCreateFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentFavoriteStatus)
        XCTAssertEqual(sut.character, updatedCharacter)
        XCTAssertEqual(updatedCharacter, presenter.invokedPresentFavoriteStatusParameters?.response.character)
    }
    
    func testhandleSaveFavoriteStatusWhenFailureToCreate() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        worker.createFavoriteCharactorResponse = .failure(.defaultError)
        sut.character = character
        sut.handleSaveFavoriteStatus(request: .init())
        
        // Then
        XCTAssertTrue(worker.invokedCreateFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentErrorMessage)
        XCTAssertEqual(presenter.invokedPresentErrorMessageParameters?.response.error, .defaultError)
    }
    
    func testhandleSaveFavoriteStatusWhenFailureToDelete() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        
        // When
        worker.deleteFavoriteCharactorResponse = .failure(.defaultError)
        sut.character = character
        sut.handleSaveFavoriteStatus(request: .init())
        
        // Then
        XCTAssertTrue(worker.invokedDeleteFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentErrorMessage)
        XCTAssertEqual(presenter.invokedPresentErrorMessageParameters?.response.error, .defaultError)
    }
    
    private func makeSUT() -> (sut: DetailsInteractor, presenter: DetailsPresenterSpy, worker: DetailsStub) {
        let sut = DetailsInteractor()
        let presenter = DetailsPresenterSpy()
        let worker = DetailsStub()
        
        sut.presenter = presenter
        sut.worker = worker
        
        return(sut, presenter, worker)
    }
}
