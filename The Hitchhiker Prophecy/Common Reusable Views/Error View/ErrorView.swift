//
//  ErrorView.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/24/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import UIKit

class ErrorView: UIView, NibLoadable {

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    @IBOutlet private weak var retryButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction private func retryButtonTapped(_ sender: UIButton) {
        
    }
}
