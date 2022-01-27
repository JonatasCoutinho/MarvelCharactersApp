//
//  DetailsPresenterTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class DetailsPresenterTests: XCTestCase {
    
    func testPresentCharacterInfoWhenThereAreEmpyValues() {
        // Given
        let (sut, vc) = makeSUT()
        let character = Character(id: 0, name: "", description: "", image: nil, isFavorite: false)
        
        // When
        sut.presentCharacterInfo(response: .init(character: character))
        
        // Then
        XCTAssertTrue(vc.invokedDisplayCharacterInfo)
        XCTAssertEqual(vc.invokedDisplayCharacterInfoParameters?.viewModel.name, "Unavailable Name")
        XCTAssertEqual(vc.invokedDisplayCharacterInfoParameters?.viewModel.detail, "Unavailable Description")
        XCTAssertEqual(vc.invokedDisplayCharacterInfoParameters?.viewModel.image, UIImage(systemName: "clear")!)
    }
    
    func testPresentCharacterInfoWhenThereAreNoEmpyValues() {
        // Given
        let (sut, vc) = makeSUT()
        let character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        sut.presentCharacterInfo(response: .init(character: character))
        
        // Then
        XCTAssertTrue(vc.invokedDisplayCharacterInfo)
        XCTAssertEqual(vc.invokedDisplayCharacterInfoParameters?.viewModel.name, character.name)
        XCTAssertEqual(vc.invokedDisplayCharacterInfoParameters?.viewModel.detail, character.description)
        XCTAssertEqual(vc.invokedDisplayCharacterInfoParameters?.viewModel.image, character.image)
    }
    
    func testPresentFavoriteStatusWhenThereAreEmpyValues() {
        // Given
        let (sut, vc) = makeSUT()
        let character = Character(id: 0, name: "", description: "", image: nil, isFavorite: false)
        
        // When
        sut.presentFavoriteStatus(response: .init(character: character))
        
        // Then
        XCTAssertTrue(vc.invokedDisplayFavoriteStatus)
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.name, "Unavailable Name")
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.detail, "Unavailable Description")
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.image, UIImage(systemName: "clear")!)
    }
    
    func testPresentFavoriteStatusWhenThereAreNoEmpyValues() {
        // Given
        let (sut, vc) = makeSUT()
        let character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        sut.presentFavoriteStatus(response: .init(character: character))
        
        // Then
        XCTAssertTrue(vc.invokedDisplayFavoriteStatus)
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.name, character.name)
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.detail, character.description)
        XCTAssertEqual(vc.invokedDisplayFavoriteStatusParameters?.viewModel.image, character.image)
    }
    
    func testPresentErrorMessage() {
        // Given
        let (sut, vc) = makeSUT()
        let response = Details.ErrorMessage.Response(error: .defaultError)

        // When
        sut.presentErrorMessage(response: response)
        
        // Then
        XCTAssertTrue(vc.invokedDisplayErrorMessage)
        XCTAssertEqual(vc.invokedDisplayErrorMessageParameters?.viewModel.message, response.error.message)
    }
    
    private func makeSUT() -> (sut: DetailsPresenter, vc: DetailsViewControllerSpy) {
        let sut = DetailsPresenter()
        let vc = DetailsViewControllerSpy()
        
        sut.viewController = vc
        
        return(sut, vc)
    }
}
