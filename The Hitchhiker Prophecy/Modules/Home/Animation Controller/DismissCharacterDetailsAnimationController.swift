//
//  DismissCharacterDetailsAnimationController.swift
//  The Hitchhiker Prophecy
//
//  Created by Omar Tarek on 3/25/21.
//  Copyright © 2021 SWVL. All rights reserved.
//

import Foundation
import UIKit

class DismissCharacterDetailsAnimationController: NSObject {
    
    static let duration: TimeInterval = 0.25
    
    private let sourceViewController: HomeSceneViewController
    private let destinationViewController: CharacterDetailsSceneViewController
    private var selectedCellImageViewSnapshot: UIView
    private let cellImageViewRect: CGRect
    
    init?(sourceViewController: HomeSceneViewController,
          destinationViewController: CharacterDetailsSceneViewController,
          selectedCellImageViewSnapshot: UIView) {
        
        self.sourceViewController = sourceViewController
        self.destinationViewController = destinationViewController
        self.selectedCellImageViewSnapshot = selectedCellImageViewSnapshot
        
        guard let window = sourceViewController.view.window ?? destinationViewController.view.window,
              let selectedCell = sourceViewController.selectedCell
        else { return nil }
        
        self.cellImageViewRect = selectedCell.characterImageView.convert(selectedCell.characterImageView.bounds, to: window)
    }
    
}

extension DismissCharacterDetailsAnimationController: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        guard let toView = destinationViewController.view
        else {
            transitionContext.completeTransition(false)
            return
        }
        containerView.addSubview(toView)
        
        guard let selectedCell = sourceViewController.selectedCell,
              let window = sourceViewController.view.window ?? destinationViewController.view.window,
              let cellImageSnapshot = selectedCell.snapshotView(afterScreenUpdates: true),
              let controllerImageSnapshot = destinationViewController.characterImageView.snapshotView(afterScreenUpdates: true)
        else {
            transitionContext.completeTransition(true)
            return
        }
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = destinationViewController.view.backgroundColor
        backgroundView = sourceViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
        backgroundView.addSubview(fadeView)
        toView.alpha = 0
        [backgroundView, selectedCellImageViewSnapshot, controllerImageSnapshot].forEach { containerView.addSubview($0) }

        let controllerImageViewRect = destinationViewController.characterImageView.convert(destinationViewController.characterImageView.bounds, to: window)

        [selectedCellImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = controllerImageViewRect
        }

        controllerImageSnapshot.alpha = 1
        selectedCellImageViewSnapshot.alpha = 0
        
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic, animations: {
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedCellImageViewSnapshot.frame = self.cellImageViewRect
                self.selectedCellImageViewSnapshot.transform = CGAffineTransform(scaleX: 1.4, y: 1)
                controllerImageSnapshot.frame = self.cellImageViewRect
                fadeView.alpha = 0
            }
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedCellImageViewSnapshot.alpha = 1
                controllerImageSnapshot.alpha = 0
            }
            
        }, completion: { _ in
            self.selectedCellImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            toView.alpha = 1
            transitionContext.completeTransition(true)
        })
        
    }
    
}
