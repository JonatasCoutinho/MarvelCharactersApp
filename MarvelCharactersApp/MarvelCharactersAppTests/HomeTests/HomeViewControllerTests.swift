//
//  HomeViewControllerTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class HomeViewControllerTests: XCTestCase {
    
    func testInteractorCallLoadView() {
        // Given
        let (sut, interactor, _) = makeSUT()
        let window = UIWindow()
        
        // When
        window.addSubview(sut.view)
        
        // Then
        XCTAssertTrue(interactor.invokedHandleFetchCharactersList)
    }
    
    func testSetupUI() {
        // Given
        let (sut, _, _) = makeSUT()
        let window = UIWindow()
        
        // When
        window.addSubview(sut.view)
        sut.setupUI()
        
        // Then
        XCTAssertEqual(sut.navigationItem.searchController, sut.searchController)
        XCTAssertEqual(sut.charactersTableView.superview, sut.view)
    }
    
    func testDisplayCharactersTableViewUpdate() {
        // Given
        let (sut, _, _) = makeSUT()
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        
        
        DispatchQueue.main.async{
            // When
            sut.displayCharacters(viewModel: .init(characters: characters))
            
            // Then
            XCTAssertEqual(sut.characters, characters)
            XCTAssertEqual(sut.charactersTableView.numberOfRows(inSection: 0), sut.characters.count)
        }
    }
    
    func testDisplayFilterCharactersTableViewUpdate() {
        // Given
        let (sut, _, _) = makeSUT()
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        
        // When
        sut.displayFilterCharacters(viewModel: .init(characters: characters))
        
        // Then
        XCTAssertEqual(sut.characters, characters)
        XCTAssertEqual(sut.charactersTableView.numberOfRows(inSection: 0), sut.characters.count)
    }
    
    func testDisplayUpdateFavoriteCharacterTableViewUpdate() {
        // Given
        let (sut, _, _) = makeSUT()
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        
        // When
        sut.searchController.isActive = true
        sut.displayUpdateFavoriteCharacter(viewModel: .init(characters: characters))
        
        // Then
        XCTAssertEqual(sut.characters, characters)
        XCTAssertEqual(sut.charactersTableView.numberOfRows(inSection: 0), sut.characters.count)
        XCTAssertFalse(sut.searchController.isActive)
    }
    
    func testTableViewSelectionRouterCall () {
        // Given
        let (sut, _, router) = makeSUT()
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]

        // When
        sut.characters = characters
        sut.charactersTableView.reloadData()
        sut.charactersTableView.delegate?.tableView?(sut.charactersTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertTrue(router.invokedRouteToDetailScreen)
        XCTAssertEqual(router.invokedRouteToDetailScreenParameters?.characterID, characters.first?.id)
    }
    
    func testUpdateSearchResultsInteractorCall() {
        // Given
        let (sut, interactor, _) = makeSUT()
        
        // When
        sut.searchController.searchBar.text = "test"
        sut.updateSearchResults(for: sut.searchController)
        
        // Then
        XCTAssertTrue(interactor.invokedHandleFilterCharacters)
        XCTAssertEqual(interactor.invokedHandleFilterCharactersParameters?.request.searchText, sut.searchController.searchBar.text)
    }
    
    func testNotifyCharacterFavoriteStatusCall() {
        // Given
        let (sut, interactor, _) = makeSUT()
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        sut.notifyCharacterFavoriteStatus(character: character)
        
        // Then
        XCTAssertTrue(interactor.invokedHandleUpdateFavoriteCharacter)
        XCTAssertEqual(interactor.invokedHandleUpdateFavoriteCharacterParameters?.request.character, character)
    }
    
    func testUpdateFavoriteCharacterStatusCall() {
        // Given
        let (sut, interactor, _) = makeSUT()
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        sut.handleUpdateFavoriteCharacterStatus(character: character)
        
        // Then
        XCTAssertTrue(interactor.invokedHandleSaveFavoriteStatus)
        XCTAssertEqual(interactor.invokedHandleSaveFavoriteStatusParameters?.request.character, character)
    }

    private func makeSUT() -> (sut: HomeViewController, interactor: HomeInteractorSpy, router: HomeRouterSpy) {
        let interactor = HomeInteractorSpy()
        let router = HomeRouterSpy()
        let sut = HomeViewController()
        sut.interactor = interactor
        sut.router = router
        
        return(sut, interactor, router)
    }
}

