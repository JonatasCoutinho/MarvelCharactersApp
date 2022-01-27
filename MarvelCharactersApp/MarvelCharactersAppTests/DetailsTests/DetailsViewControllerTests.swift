//
//  DetailsViewControllerTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 26/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class DetailsViewControllerTests: XCTestCase {
    
    func testInteractorCallLoadView() {
        // Given
        let (sut, interactor, _) = makeSUT()
        let window = UIWindow()
        
        // When
        window.addSubview(sut.view)
        
        // Then
        XCTAssertTrue(interactor.invokedHandleGetCharacterInfo)
    }
    
    func testSetupUI() {
        // Given
        let (sut, _, _) = makeSUT()
        let window = UIWindow()

        // When
        window.addSubview(sut.view)
        sut.setupUI()

        // Then
        XCTAssertEqual(sut.characterImageView.superview, sut.view)
        XCTAssertEqual(sut.nameLabel.superview, sut.view)
        XCTAssertEqual(sut.detailTextView.superview, sut.view)
        XCTAssertEqual(sut.favoriteButton.superview, sut.view)
    }
    
    func testInteractorCallFavoriteButtonTap() {
        // Given
        let (sut, interactor, _) = makeSUT()
        
        // When
        sut.handleFavoriteButtonTap(sender: .init())
        
        // Then
        XCTAssertTrue(interactor.invokedHandleSaveFavoriteStatus)
    }
    
    func testDisplayCharacterInfo() {
        // Given
        let (sut, _, _) = makeSUT()
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)

        // When
        sut.displayCharacterInfo(viewModel: .init(character: character, name: character.name, detail: character.description, image: character.image!))
        
        // Then
        XCTAssertEqual(sut.character, character)
        XCTAssertEqual(sut.nameLabel.text, character.name)
        XCTAssertEqual(sut.detailTextView.text, character.description)
        XCTAssertEqual(sut.characterImageView.image, character.image)
    }

    private func makeSUT() -> (sut: DetailsViewController, interactor: DetailsInteractorSpy, router: DetailsRouterSpy) {
        let interactor = DetailsInteractorSpy()
        let router = DetailsRouterSpy()
        let sut = DetailsViewController()
        sut.interactor = interactor
        sut.router = router
        
        return(sut, interactor, router)
    }
}

