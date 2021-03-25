//
//  HomeSceneViewController.swift
//  The Hitchhiker Prophecy
//
//  Created by Mohamed Matloub on 6/10/20.
//  Copyright © 2020 SWVL. All rights reserved.
//

import UIKit

class HomeSceneViewController: UIViewController, LoadingViewCapable, ErrorDisplaying {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var charactersListView: CharactersListView! {
        didSet {
            charactersListView.delegate = self
        }
    }
    
    // MARK: - Properties
    
    private(set) weak var selectedCell: CharacterCollectionViewCell?
    
    // MARK: - Dependencies
    
    var interactor: HomeSceneBusinessLogic?
    var router: HomeSceneRoutingLogic?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor?.fetchCharacters()
    }
}

extension HomeSceneViewController: HomeSceneDisplayView {
    func didFetchCharacters(viewModel: [HomeScene.Search.ViewModel]) {
        charactersListView.configure(viewModel)
    }
    
    func failedToFetchCharacters(error: Error) {
        showErrorView(error)
    }
    
    func retry() {
        interactor?.fetchCharacters()
    }
}

extension HomeSceneViewController: CharactersListViewDelegate {
    func charactersListView(charactersListView: CharactersListView, didTapOnCharacterWith index: Int, for cell: CharacterCollectionViewCell?) {
        selectedCell = cell
        router?.routeToCharacterDetailsWithCharacter(at: index)
    }
}

extension HomeSceneViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let sourceViewController = (presenting as? UINavigationController)?.viewControllers.first as? HomeSceneViewController,
              let destinationViewController = presented as? CharacterDetailsSceneViewController,
              let selectedCell = selectedCell?.characterImageView else { return nil }

        return PresentCharacterDetailsAnimationController(sourceViewController: sourceViewController,
                                                          destinationViewController: destinationViewController,
                                                          selectedCellImageViewSnapshot: selectedCell)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let destinationViewController = dismissed as? CharacterDetailsSceneViewController,
              let selectedCell = selectedCell?.characterImageView else { return nil }
        return DismissCharacterDetailsAnimationController(sourceViewController: self,
                                                          destinationViewController: destinationViewController,
                                                          selectedCellImageViewSnapshot: selectedCell)
    }
}
