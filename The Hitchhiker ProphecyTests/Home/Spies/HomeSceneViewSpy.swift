//
//  HomeSceneViewSpy.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Omar Tarek on 3/24/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy

class HomeSceneViewSpy: HomeSceneDisplayView {
    
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    
    var charactersViewModel: [HomeScene.Search.ViewModel]?
    var error: Error?
    var isShowingLoadingIndicator: Bool?
    
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        charactersViewModel = viewModel
    }
    
    func failedToFetchCharacters(error: Error) {
        self.error = error
    }
    
    func showLoading() {
        isShowingLoadingIndicator = true
    }
    
    func hideLoading() {
        isShowingLoadingIndicator = false
    }
}
