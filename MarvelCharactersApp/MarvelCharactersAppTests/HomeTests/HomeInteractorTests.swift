//
//  HomeInteractorTests.swift
//  MarvelCharactersAppTests
//
//  Created by Jonatas Coutinho de Faria on 25/01/22.
//

import Foundation
@testable import MarvelCharactersApp
import XCTest

class HomeInteractorTests: XCTestCase {

    func testHandleFetchCharactersListWhenCharacterIsFavorite() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        let request: Home.FetchCharacters.Request = .init()
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: nil, isFavorite: false)
        let characterWithImage: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        let characterFavorite: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        
        // When
        worker.fetchCharactersResponse = .success([character])
        worker.fetchCharactersImageResponse = [characterWithImage]
        worker.fetchFavoritesIdsResponse = .success([characterWithImage.id ?? 0])
        sut.handleFetchCharactersList(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedFetchCharacters)
        XCTAssertTrue(worker.invokedFetchCharactersImage)
        XCTAssertTrue(worker.invokedFetchFavoritesIds)
        XCTAssertTrue(presenter.invokedPresentCharacters)
        
        XCTAssertEqual(sut.characters?.first, characterFavorite)
        XCTAssertEqual(presenter.invokedPresentCharactersParameters?.response.characters?.first, characterFavorite)
    }
    
    func testHandleFetchCharactersListWhenCharacterIsNotFavorite() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        let request: Home.FetchCharacters.Request = .init()
        let character: Character = Character(id: 0, name: "testName", description: "testDescription", image: nil, isFavorite: false)
        let characterWithImage: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        // When
        worker.fetchCharactersResponse = .success([character])
        worker.fetchCharactersImageResponse = [characterWithImage]
        worker.fetchFavoritesIdsResponse = .success([1])
        sut.handleFetchCharactersList(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedFetchCharacters)
        XCTAssertTrue(worker.invokedFetchCharactersImage)
        XCTAssertTrue(worker.invokedFetchFavoritesIds)
        XCTAssertTrue(presenter.invokedPresentCharacters)
        
        XCTAssertEqual(sut.characters?.first, characterWithImage)
        XCTAssertEqual(presenter.invokedPresentCharactersParameters?.response.characters?.first, characterWithImage)
    }
    
    func testHandleFetchCharactersListWhenFailureToCharactersReponse() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        let request: Home.FetchCharacters.Request = .init()
        
        // When
        worker.fetchCharactersResponse = .failure(.defaultError)
        sut.handleFetchCharactersList(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedFetchCharacters)
        XCTAssertTrue(presenter.invokedPresentErrorMessage)
        XCTAssertEqual(presenter.invokedPresentErrorMessageParameters?.response.error, .defaultError)
    }
    
    func testhandleFilterCharactersWhenTextIsEmpty() {
        // Given
        let (sut, presenter, _) = makeSUT()
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        let request: Home.FilterCharacters.Request = .init(searchText: "")
        
        // When
        sut.characters = characters
        sut.handleFilterCharacters(request: request)
        
        // Then
        XCTAssertTrue(presenter.invokedPresentFilterCharacters)
        XCTAssertEqual(presenter.invokedPresentFilterCharactersParameters?.response.characters, sut.characters)
    }
    
    func testhandleFilterCharactersWhenTextIsNotEmpty() {
        // Given
        let (sut, presenter, _) = makeSUT()
        let characters: [Character] = [Character(id: 0, name: "testA", description: "testDescription", image: UIImage(), isFavorite: false), Character(id: 0, name: "testB", description: "testDescription", image: UIImage(), isFavorite: false)]
        let request: Home.FilterCharacters.Request = .init(searchText: "A")
        
        // When
        sut.characters = characters
        sut.handleFilterCharacters(request: request)
        
        // Then
        XCTAssertTrue(presenter.invokedPresentFilterCharacters)
        XCTAssertEqual(presenter.invokedPresentFilterCharactersParameters?.response.characters, [characters[0]])
    }
    
    func testhandleUpdateFavoriteCharacter() {
        // Given
        let (sut, presenter, _) = makeSUT()
        
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        
        let request: Home.UpdateCharacter.Request = .init(character: updatedCharacter)
        
        // When
        sut.characters = characters
        sut.handleUpdateFavoriteCharacter(request: request)
        
        // Then
        XCTAssertTrue(presenter.invokedPresentUpdateFavoriteCharacter)
        XCTAssertEqual(sut.characters?.first, updatedCharacter)
        XCTAssertEqual(presenter.invokedPresentUpdateFavoriteCharacterParameters?.response.characters?.first, updatedCharacter)
    }
    
    func testhandleSaveFavoriteStatusWhenCharacterIsFavorite() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)]
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        let request: Home.SaveFavoriteStatus.Request = .init(character: updatedCharacter)
        
        // When
        sut.characters = characters
        worker.deleteFavoriteCharactorResponse = .success(true)
        sut.handleSaveFavoriteStatus(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedDeleteFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentFavoriteStatus)
        XCTAssertEqual([updatedCharacter], sut.characters)
        XCTAssertEqual([updatedCharacter], presenter.invokedPresentFavoriteStatusParameters?.response.characters)
    }
    
    func testhandleSaveFavoriteStatusWhenCharacterIsNotFavorite() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        
        let request: Home.SaveFavoriteStatus.Request = .init(character: updatedCharacter)
        
        // When
        sut.characters = characters
        worker.createFavoriteCharactorResponse = .success(true)
        sut.handleSaveFavoriteStatus(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedCreateFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentFavoriteStatus)
        XCTAssertEqual([updatedCharacter], sut.characters)
        XCTAssertEqual([updatedCharacter], presenter.invokedPresentFavoriteStatusParameters?.response.characters)
    }
    
    func testhandleSaveFavoriteStatusWhenCharacterFailureToCreate() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)]
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)
        
        let request: Home.SaveFavoriteStatus.Request = .init(character: updatedCharacter)
        
        // When
        sut.characters = characters
        worker.createFavoriteCharactorResponse = .failure(.defaultError)
        sut.handleSaveFavoriteStatus(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedCreateFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentErrorMessage)
        XCTAssertEqual(presenter.invokedPresentErrorMessageParameters?.response.error, .defaultError)
    }
    
    func testhandleSaveFavoriteStatusWhenCharacterFailureToDelete() {
        // Given
        let (sut, presenter, worker) = makeSUT()
        
        let characters: [Character] = [Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: true)]
        let updatedCharacter: Character = Character(id: 0, name: "testName", description: "testDescription", image: UIImage(), isFavorite: false)
        
        let request: Home.SaveFavoriteStatus.Request = .init(character: updatedCharacter)
        
        // When
        sut.characters = characters
        worker.createFavoriteCharactorResponse = .failure(.defaultError)
        sut.handleSaveFavoriteStatus(request: request)
        
        // Then
        XCTAssertTrue(worker.invokedDeleteFavoriteCharactor)
        XCTAssertTrue(presenter.invokedPresentErrorMessage)
        XCTAssertEqual(presenter.invokedPresentErrorMessageParameters?.response.error, .defaultError)
    }
    
    private func makeSUT() -> (sut: HomeInteractor, presenter: HomePresenterSpy, worker: HomeStub) {
        let sut = HomeInteractor()
        let presenter = HomePresenterSpy()
        let worker = HomeStub()
        
        sut.presenter = presenter
        sut.worker = worker
        
        return(sut, presenter, worker)
    }
}
