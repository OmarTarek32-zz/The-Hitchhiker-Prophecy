//
//  CharactersListView.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/23/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

protocol CharactersListViewDelegate: AnyObject {
    func charactersListView(charactersListView: CharactersListView, didTapOnCharacterWith index: Int)
}

class CharactersListView: UIView, NibLoadable {
    
    // MARK: - Nested Type
    
    enum Layout {
        case grid(frame: CGRect)
        case list(frame: CGRect)
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var charactersCollectionView: UICollectionView! {
        didSet{
            charactersCollectionView.delegate = self
            charactersCollectionView.dataSource = self
            charactersCollectionView.collectionViewLayout = currentLayout.collectionViewFlowLayout
            charactersCollectionView.registerCell(withCellType: CharacterCollectionViewCell.self)
        }
    }
    
    // MARK: - Properties
    
    weak var delegate: CharactersListViewDelegate?
    
    private var characters: [HomeScene.Search.ViewModel] = []
        
    private lazy var currentLayout = Layout.list(frame: frame)
    
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
        currentLayout.toggle()
        charactersCollectionView.startInteractiveTransition(to: currentLayout.collectionViewFlowLayout, completion: nil)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.charactersListView(charactersListView: self, didTapOnCharacterWith: indexPath.row)
    }
}

extension CharactersListView.Layout {
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout {
        switch self {
        case .grid(let frame):
            let collectionFlowLayout = UICollectionViewFlowLayout()
            collectionFlowLayout.scrollDirection = .vertical
            collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            collectionFlowLayout.itemSize = CGSize(width: (frame.width - 80) / 2 , height: frame.height*0.16)
            collectionFlowLayout.minimumInteritemSpacing = 20
            collectionFlowLayout.minimumLineSpacing = 20
            return collectionFlowLayout
            
        case .list(let frame):
            let collectionFlowLayout = UICollectionViewFlowLayout()
            collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            collectionFlowLayout.itemSize = CGSize(width: frame.width, height: 300)
            collectionFlowLayout.minimumInteritemSpacing = 0
            collectionFlowLayout.minimumLineSpacing = 0
            collectionFlowLayout.scrollDirection = .vertical
            return collectionFlowLayout
        }
    }
    
    mutating func toggle() {
        switch self {
        case .grid(let frame):
            self = .list(frame: frame)
        case .list(let frame):
            self = .grid(frame: frame)
        }
    }
}
