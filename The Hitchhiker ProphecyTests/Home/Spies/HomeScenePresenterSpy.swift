//
//  HomeScenePresenterSpy.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Omar Tarek on 3/25/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy

class HomeScenePresenterSpy: HomeScenePresentationLogic {
    
    var displayView: HomeSceneDisplayView?
    var responseSuccess: Characters.Search.Output?
    var responseError: Error?
    
    func presentCharacters(_ response: HomeScene.Search.Response) {
        switch response {
        case .success(let output):
            responseSuccess = output
            responseError = nil
        case .failure(let error):
            responseError = error
            responseSuccess = nil
        }
    }
    
    func showLoadingView() {
        displayView?.showLoading()
    }
    
    func hideLoadingView() {
        displayView?.hideLoading()
    }
    
}
