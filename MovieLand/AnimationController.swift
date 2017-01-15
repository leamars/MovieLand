//
//  AnimationController.swift
//  MovieLand
//
//  Created by Lea Marolt on 1/14/17.
//  Copyright © 2017 Razeware. All rights reserved.
//

import UIKit

//class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
//    
//    var originFrame = CGRect.zero
//    
//    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//        return 2.0
//    }
//    
//    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        // 1
//        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
//            let containerView = transitionContext.containerView,
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
//                return
//        }
//        
//        // 2
//        let initialFrame = originFrame
//        let finalFrame = transitionContext.finalFrame(for: toVC)
//        
//        // 3
//        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
//        snapshot?.frame = initialFrame
//        snapshot?.layer.cornerRadius = 25
//        snapshot?.layer.masksToBounds = true
//    }
//}
