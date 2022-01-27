//
//  HomePresenterTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class HomePresenterTests: XCTestCase {
    
    func testPresentCharacters() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Home.FetchCharacters.Response(characters: [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)])
        // When
        sut.presentCharacters(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayCharacters)
        XCTAssertEqual(vc.invokedDisplayCharactersParameters?.viewModel.characters, response.characters)
    }
    
    func testPresentFilterCharacters() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Home.FetchCharacters.Response(characters: [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)])
        
        // When
        sut.presentFilterCharacters(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayFilterCharacters)
        XCTAssertEqual(vc.invokedDisplayFilterCharactersParameters?.viewModel.characters, response.characters)
    }
    
    func testPresentUpdateFavoriteCharacter() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Home.UpdateCharacter.Response(characters: [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)])
        
        // When
        sut.presentUpdateFavoriteCharacter(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayUpdateFavoriteCharacter)
        XCTAssertEqual(vc.invokedDisplayUpdateFavoriteCharacterParameters?.viewModel.characters, response.characters)
    }
    
    func testPresentFavoriteStatus() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Home.SaveFavoriteStatus.Response(characters: [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)])

        // When
        sut.presentFavoriteStatus(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayFavoriteStatus)
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.characters, response.characters)
    }
    
    func testPresentErrorMessage() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Home.ErrorMessage.Response(error: .defaultError)

        // When
        sut.presentErrorMessage(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayErrorMessage)
        XCTAssertEqual(vc.invokedDisplayErrorMessageParameters?.viewModel.message, response.error.message)
    }
    
    private func makeSUT() -> (sut: HomePresenter, vc: HomeViewControllerSpy) {
        let sut = HomePresenter()
        let vc = HomeViewControllerSpy()
        
        sut.viewController = vc
        
        return(sut, vc)
    }
}
