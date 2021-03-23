//
//  CharactersListView.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/23/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

class CharactersListView: UIView, NibLoadable {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
    }
    
}
