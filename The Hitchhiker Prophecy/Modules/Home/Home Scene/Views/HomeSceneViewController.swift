//
//  HomeSceneViewController.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import UIKit

class HomeSceneViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var charactersListView: CharactersListView! {
        didSet {
            charactersListView.delegate = self
        }
    }
    
    // MARK: - Dependencies
    
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacters()
    }
    
    @IBAction func changeLayoutButtonTapped(_ sender: UIButton) {
        charactersListView.switchLayout()
    }
}

extension HomeSceneViewController: HomeSceneDisplayView {
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        charactersListView.configure(viewModel)
    }
    
    func failedToFetchCharacters(error: Error) {
        // TODO: Implement
    }
}

extension HomeSceneViewController: CharactersListViewDelegate {
    
    func charactersListView(charactersListView: CharactersListView, didTapOnCharacterWith index: Int) {
        router?.routeToCharacterDetailsWithCharacter(at: index)
    }
}
