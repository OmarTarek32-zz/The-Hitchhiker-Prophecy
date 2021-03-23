//
//  CharactersListView.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/23/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

class CharactersListView: UIView, NibLoadable {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var charactersCollectionView: UICollectionView! {
        didSet{
            charactersCollectionView.delegate = self
            charactersCollectionView.dataSource = self
            charactersCollectionView.collectionViewLayout = listLayout
            charactersCollectionView.registerCell(withCellType: CharacterCollectionViewCell.self)
        }
    }
    
    // MARK: - Properties
    
    private var characters: [HomeScene.Search.ViewModel] = []
    
    private lazy var listLayout: UICollectionViewFlowLayout = {

        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionFlowLayout.itemSize = CGSize(width: frame.width, height: 300)
        collectionFlowLayout.minimumInteritemSpacing = 0
        collectionFlowLayout.minimumLineSpacing = 0
        collectionFlowLayout.scrollDirection = .vertical
        return collectionFlowLayout
    }()

    private lazy var gridLayout: UICollectionViewFlowLayout = {
        
        let collectionFlowLayout = UICollectionViewFlowLayout()
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
        collectionFlowLayout.itemSize = CGSize(width: (frame.width - 80) / 2 , height: frame.height*0.16)
        collectionFlowLayout.minimumInteritemSpacing = 20
        collectionFlowLayout.minimumLineSpacing = 20
        return collectionFlowLayout
    }()
    
    private var isListView = true
    
    // MARK: - Life Cycle Functions
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
    }
    
    // MARK: - Functions
    
    func configure(_ data: [HomeScene.Search.ViewModel]) {
        characters = data
        charactersCollectionView.reloadData()
    }
    
    func switchLayout() {
        let currentLayout = isListView ? gridLayout : listLayout
        isListView.toggle()
        charactersCollectionView.startInteractiveTransition(to: currentLayout, completion: nil)
        charactersCollectionView.finishInteractiveTransition()
    }
    
}

extension CharactersListView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharacterCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(with: characters[indexPath.row])
        return cell
    }
    
}
