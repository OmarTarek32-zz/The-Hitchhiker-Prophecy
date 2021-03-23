//
//  ReusableUIViewExtension.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/23/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
import UIKit

protocol NibNaming {
    var nibName: String { get }
}

protocol NibLoadable: NibNaming {
    func loadNibContent()
}

extension NibLoadable where Self: UIView {
    
    var nibName: String {
        String(describing: Self.self)
    }
    
    func loadNibContent() {
        guard let view = loadViewFromNib() else { return }
        view.frame = bounds
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
