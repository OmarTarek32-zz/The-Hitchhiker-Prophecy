//
//  PresentCharacterDetailsAnimationController.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/24/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
import UIKit

class PresentCharacterDetailsAnimationController: NSObject {
    
    private let originFrame: CGRect

    init(originFrame: CGRect) {
      self.originFrame = originFrame
    }

}

extension PresentCharacterDetailsAnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
}
