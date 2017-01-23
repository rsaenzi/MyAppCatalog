//
//  AnimatorSplashToNavMain.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/23/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Foundation

class AnimatorSplashToNavMain: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        
        // Extracts the conteiner for both screen while are animated...
        let container = transitionContext.containerView()
        
        // Extracts the screens involved in the transition
        let source = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let target = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        // Get the duration from above
        let duration = self.transitionDuration(transitionContext)
        
        
        // The initial size is the current one
        let targetSize = transitionContext.finalFrameForViewController(target)
        target.view.frame = targetSize
        
        // Target screen is added to transition container
        container.addSubview(target.view)
        
        // But is send back because the source screen must be shown over it
        container.sendSubviewToBack(target.view)
        
        
        // Takes a screenshot of source screen
        let sourceScreenshot = source.view.snapshotViewAfterScreenUpdates(true)!
        
        // Sets this flag to see any border animation
        sourceScreenshot.clipsToBounds = true
        
        // Sets the size of the screenshot
        sourceScreenshot.frame = source.view.frame
        
        // Adds the screenshot to transition container
        container.addSubview(sourceScreenshot)
        
        // At this point, the source screen is not needed, so we removed it...
        source.view.removeFromSuperview()
        
        
        // The transition begins...
        UIView.animateWithDuration(duration, animations: {
            
            // The screenshot gradually becomes smaller
            sourceScreenshot.frame = CGRectInset(source.view.frame, source.view.frame.size.width / 2, source.view.frame.size.height / 2)
            
            // The screenshot gradually becomes transparent
            sourceScreenshot.alpha = 0
            
            }, completion: { finished in
                
                // The screenshot can be safely remove at this point
                sourceScreenshot.removeFromSuperview()
                
                // The animation is over
                transitionContext.completeTransition(true)
        })
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
