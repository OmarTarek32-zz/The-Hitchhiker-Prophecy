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
        case gallery(frame: CGRect)
        case list(frame: CGRect)
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var changeLayoutButton: UIButton!
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
        
    private lazy var currentLayout = Layout.list(frame: charactersCollectionView.frame)
    
    // MARK: - Life Cycle Functions
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
        
    }
    
    // MARK: - Functions
    
    func updateLayout() {
        currentLayout.update(frame: charactersCollectionView.frame)
    }
    
    func configure(_ data: [HomeScene.Search.ViewModel]) {
        characters = data
        charactersCollectionView.reloadData()
    }
    
    private func switchLayout() {
        currentLayout.toggle()
        changeLayoutButton.isEnabled = false
        charactersCollectionView.startInteractiveTransition(to: currentLayout.collectionViewFlowLayout) { [weak changeLayoutButton] _, _ in
            changeLayoutButton?.isEnabled = true
        }
        charactersCollectionView.finishInteractiveTransition()
    }
    
    @IBAction func changeLayoutButtonTapped(_ sender: UIButton) {
        switchLayout()
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
        case .gallery(let frame):
            let collectionFlowLayout = UICollectionViewFlowLayout()
            collectionFlowLayout.scrollDirection = .horizontal
            collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            collectionFlowLayout.itemSize = CGSize(width: frame.width - (frame.width * 0.2) , height: frame.height*0.85)
            collectionFlowLayout.minimumInteritemSpacing = 20
            collectionFlowLayout.minimumLineSpacing = 20
            return collectionFlowLayout
            
        case .list(let frame):
            let collectionFlowLayout = UICollectionViewFlowLayout()
            collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            collectionFlowLayout.itemSize = CGSize(width: frame.width - max((frame.width * 0.05), 50), height: 200)
            collectionFlowLayout.minimumInteritemSpacing = 10
            collectionFlowLayout.minimumLineSpacing = 10
            collectionFlowLayout.scrollDirection = .vertical
            return collectionFlowLayout
        }
    }
    
    mutating func toggle() {
        switch self {
        case .gallery(let frame):
            self = .list(frame: frame)
        case .list(let frame):
            self = .gallery(frame: frame)
        }
    }
    
    mutating func update(frame: CGRect) {
        switch self {
        case .gallery(let frame):
            self = .gallery(frame: frame)
        case .list(let frame):
            self = .list(frame: frame)
        }
    }
}
