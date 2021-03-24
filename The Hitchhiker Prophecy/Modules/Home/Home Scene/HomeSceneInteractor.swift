//
//  HomeSceneInteractor.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/13/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation

class HomeSceneInteractor: HomeSceneDataStore {
    
    let worker: HomeWorkerType
    let presenter: HomeScenePresentationLogic
    
    var result: Characters.Search.Results?
    
    init(worker: HomeWorkerType, presenter: HomeScenePresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
}

extension HomeSceneInteractor: HomeSceneBusinessLogic {
    func fetchCharacters() {
        
        let timeStamp = NetworkConstants.timeStamp
        let apiKey = NetworkConstants.publicKey
        let hash = NetworkConstants.apiHash
        let limit = HomeScene.Search.Constants.searchPageLimit
        let offset = result?.offset ?? 0
        
        let input = Characters.Search.Input(timeStamp: timeStamp,
                                            apiKey: apiKey,
                                            hash: hash,
                                            offset: offset,
                                            limit: limit,
                                            orderBy: .modifiedDateDescending)
        
        self.presenter.showLoadingView()
        worker.getCharacters(input) { [weak self] (result) in
            switch result {
            case .success(let value):
                var newData = value
                var oldCharacters = self?.result?.results ?? []
                oldCharacters.append(contentsOf: newData.data.results)
                newData.data.results = oldCharacters
                self?.result = newData.data
            case .failure(let error):
                print(error)
            }
            self?.presenter.presentCharacters(result)
            self?.presenter.hideLoadingView()
        }
    }
}
