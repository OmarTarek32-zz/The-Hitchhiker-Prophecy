//
//  The_Hitchhiker_ProphecyTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class HomePrsenterTests: XCTestCase {
    
    // This our system under test object
    
    var homeViewSpy: HomeSceneViewSpy!
    var sut: HomeScenePresneter?

    override func setUp() {
        super.setUp()
        
        homeViewSpy = HomeSceneViewSpy()
        sut = HomeScenePresneter(displayView: homeViewSpy)
    }
    
    override func tearDown() {
        super.tearDown()
        
        homeViewSpy = nil
        sut = nil
    }
    
    func test_init_withInjectingDispalyView_viewShouldInjectedSuccessfully() {
        // Given
        // When
        sut = HomeScenePresneter(displayView: homeViewSpy)
        // Then
        XCTAssertNotNil(sut?.displayView)
    }
    
    func test_map_shouldCreateViewModel() {
        // Given
        let testCharacter = CharactersTestData.createCharacter()
        // When
        let mappedViewModel = sut?.map(testCharacter)
        // Then
        XCTAssertEqual(testCharacter.name, mappedViewModel?.name)
        XCTAssertEqual(testCharacter.resultDescription, mappedViewModel?.desc)
        XCTAssertEqual(testCharacter.comics.collectionURI, mappedViewModel?.comics)
        XCTAssertEqual(testCharacter.series.collectionURI, mappedViewModel?.series)
        XCTAssertEqual(testCharacter.events.collectionURI, mappedViewModel?.events)
        XCTAssertEqual(testCharacter.stories.collectionURI, mappedViewModel?.stories)
    }
    
    func test_constructImageURL_shouldCreateDownloadableURL() {
        // Given
        let thumbnail = CharactersTestData.createThumbnail()
        // When
        let downloadableURL = sut?.constructImageURL(thumbnail)
        // Then
        XCTAssertEqual(downloadableURL, "https://www.photos.marvel/characters/ironman/23434.png")
    }
    
    func test_presentCharacters_withSuccessRespons_countForOutputAndMappedViewModelShouldMatch() {
        // Given
        let output = CharactersTestData.createCharactersOutput()
        // When
        sut?.presentCharacters(Swift.Result.success(output))
        // Then
        XCTAssertEqual(homeViewSpy.charactersViewModel?.count, output.data.results.count)
    }
    
    func test_presentCharacters_withSuccessRespons_viewShouldUpdated() {
        // Given
        let output = CharactersTestData.createCharactersOutput()
        // When
        sut?.presentCharacters(Swift.Result.success(output))
        // Then
        XCTAssertNotNil(homeViewSpy.charactersViewModel)
    }
    
    func test_presentCharacters_withErrorRespons_shouldShowErrorView() {
        // When
        sut?.presentCharacters(Swift.Result.failure(.server))
        // Then
        XCTAssertNotNil(homeViewSpy.error)
    }
    
    func test_showLoading() {
        // When
        sut?.showLoadingView()
        // Then
        XCTAssertTrue(homeViewSpy.isShowingLoadingIndicator ?? false)
    }
    
    func test_hideLoading() {
        // When
        sut?.hideLoadingView()
        // Then
        XCTAssertFalse(homeViewSpy.isShowingLoadingIndicator ?? true)
    }
}
