//
//  HomeWorkerMock.swift
//  The Hitchhiker ProphecyTests
//
//  Created by Omar Tarek on 3/25/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
@testable import The_Hitchhiker_Prophecy

class HomeWorkerMock: HomeWorkerType {
    
    var completion: ((HomeScene.Search.Response) -> Void)?
    
    func successResponsStub() -> Characters.Search.Output {
        CharactersTestData.createCharactersOutput()
    }
    
    func simulateGettingSuccessRespons() {
        completion?(HomeScene.Search.Response.success(successResponsStub()))
    }
    
    func simulateGettingErrorRespons() {
        completion?(HomeScene.Search.Response.failure(.server))
    }
    
    func getCharacters(_ input: Characters.Search.Input, completion: @escaping (HomeScene.Search.Response) -> Void) {
        self.completion = completion
    }
    
}
