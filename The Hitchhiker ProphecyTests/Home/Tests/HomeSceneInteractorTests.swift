//
//  HomeSceneInteractorTests.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Omar Tarek on 3/25/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import XCTest
@testable import The_Hitchhiker_Prophecy

class HomeSceneInteractorTests: XCTestCase {

    var sut: HomeSceneInteractor?
    var homeScenePresenterSpy: HomeScenePresenterSpy!
    var homeWorkerMock: HomeWorkerMock!
    var homeSceneViewSpy: HomeSceneViewSpy!
    
    override func setUp() {
        super.setUp()
        
        homeScenePresenterSpy = HomeScenePresenterSpy()
        homeWorkerMock = HomeWorkerMock()
        homeSceneViewSpy = HomeSceneViewSpy()
        homeScenePresenterSpy.displayView = homeSceneViewSpy
        sut = HomeSceneInteractor(worker: homeWorkerMock, presenter: homeScenePresenterSpy)
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        homeScenePresenterSpy = nil
        homeWorkerMock = nil
        homeSceneViewSpy = nil
    }
    
    func test_fetchCharacters_withSuccessRespons_presneterShouldReceiveData() {
        // Given
        // When
        sut?.fetchCharacters()
        homeWorkerMock.simulateGettingSuccessRespons()
        
        // Then
        XCTAssertNotNil(homeScenePresenterSpy.responseSuccess)
    }
    
    func test_fetchCharacters_withSuccessRespons_presneterShouldReceiveError() {
        // Given
        // When
        sut?.fetchCharacters()
        homeWorkerMock.simulateGettingErrorRespons()
        
        // Then
        XCTAssertNotNil(homeScenePresenterSpy.responseError)
    }
    
    func test_fetchCharacters_shouldHideLoadingAfterResponse() {
        // When
        sut?.fetchCharacters()
        homeWorkerMock.simulateGettingSuccessRespons()
        
        // Then
        XCTAssertFalse(homeSceneViewSpy.isShowingLoadingIndicator ?? true)
    }
    
    func test_fetchCharacters_shouldShowLoadingBeforeResponse() {
        // When
        sut?.fetchCharacters()
        
        // Then
        XCTAssertTrue(homeSceneViewSpy.isShowingLoadingIndicator ?? false)
    }
    
}
