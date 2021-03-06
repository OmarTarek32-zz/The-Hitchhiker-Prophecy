//
//  HomeScenePresenter.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/13/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import Foundation

class HomeScenePresneter {
    
    // MARK: - Dependencies
    
    weak var displayView: HomeSceneDisplayView?
    
    // MARK: - Initializers
    
    init(displayView: HomeSceneDisplayView) {
        self.displayView = displayView
    }
    
    // MARK: - Functions
    
    func map(_ character: Characters.Search.Character) -> HomeScene.Search.ViewModel {
        HomeScene.Search.ViewModel(name: character.name,
                                   desc: character.resultDescription,
                                   imageUrl: constructImageURL(character.thumbnail),
                                   comics: character.comics.collectionURI,
                                   series: character.series.collectionURI,
                                   stories: character.stories.collectionURI,
                                   events: character.events.collectionURI)
    }
    
    func constructImageURL(_ thumbnail: Characters.Search.Character.Thumbnail) -> String {
        "\(thumbnail.path).\(thumbnail.thumbnailExtension)"
    }
}

extension HomeScenePresneter: HomeScenePresentationLogic {
    
    func showLoadingView() {
        displayView?.showLoading()
    }
    
    func hideLoadingView() {
        displayView?.hideLoading()
    }
 
    func presentCharacters(_ response: HomeScene.Search.Response) {
        switch response {
        case .success(let output):
            displayView?.didFetchCharacters(viewModel: output.data.results.map(map(_:)))
        case .failure(let error):
            displayView?.failedToFetchCharacters(error: error)
        }
    }
    
}
