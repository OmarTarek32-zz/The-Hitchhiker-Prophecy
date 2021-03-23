//
//  HomeScenePresenter.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/13/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation

class HomeScenePresneter: HomeScenePresentationLogic {
    
    // MARK: - Dependencies
    
    weak var displayView: HomeSceneDisplayView?
    
    // MARK: - Initializers
    
    init(displayView: HomeSceneDisplayView) {
        self.displayView = displayView
    }
    
    // MARK: - Functions
    
    func presentCharacters(_ response: HomeScene.Search.Response) {
        
        switch response {
        case .success(let output):
            displayView?.didFetchCharacters(viewModel: output.data.results.map(map(_:)))
        case .failure(let error):
            displayView?.failedToFetchCharacters(error: error)
        }
    }
    
    func map(_ character: Characters.Search.Character) -> HomeScene.Search.ViewModel {
        HomeScene.Search.ViewModel(name: character.name,
                                   desc: character.resultDescription,
                                   imageUrl: constructImageURL(character.thumbnail),
                                   comics: "",
                                   series: "",
                                   stories: "",
                                   events: "")
    }
    
    func constructImageURL(_ thumbnail: Characters.Search.Character.Thumbnail) -> String {
        "\(thumbnail.path).\(thumbnail.thumbnailExtension)"
    }
}
