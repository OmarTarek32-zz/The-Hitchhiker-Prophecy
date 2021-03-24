//
//  ErrorDisplaying.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/24/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorDisplaying {
    
    func showErrorView(_ error: Error)
    func hideErrorView()
}

extension ErrorDisplaying where Self: UIViewController {
    
    func showErrorView(_ error: Error) {
        let errorView = ErrorView.instanceFromNib()
        view.addSubview(errorView)
        errorView.translatesAutoresizingMaskIntoConstraints = false
        errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func hideErrorView() {

    }
}
