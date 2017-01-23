//
//  AnimatorNavControllerMain.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/23/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Foundation

class AnimatorNavControllerMain: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    var operation = UINavigationControllerOperation.Pop
    
    
    // --------------------------------------------------
    // UIViewControllerAnimatedTransitioning
    // --------------------------------------------------
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        switch operation {
        case .Pop: return 0.4
        default:   return 1.0
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        switch operation {
        case .Pop: animationPop(transitionContext)
        default:   animationPush(transitionContext)
        }
    }
    
    
    // --------------------------------------------------
    // UIViewControllerTransitioningDelegate
    // --------------------------------------------------
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    
    // --------------------------------------------------
    // Private Methods
    // --------------------------------------------------
    private func animationPush(context: UIViewControllerContextTransitioning) {
        
        // Extracts the conteiner for both screen while are animated...
        let container = context.containerView()
        
        // Extracts the screens involved in the transition
        let source = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let target = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        // Get the duration from above
        let duration = self.transitionDuration(context)
        
        // Calculate the dependant values
        let key1Start = duration * 0.0
        let key1End   = duration * 1.0
        let key2Start = duration * 0.2
        let key2End   = duration * 0.8
        
        // Calculates the ajust value when screen has a navigation bar or item added
        let navBarAjustValue: CGFloat = source.navigationController!.navigationBar.frame.size.height + 20 // System Bar
        
        
        // Takes a screenshot of target screen
        let targetScreenshot = target.view.snapshotViewAfterScreenUpdates(true)!
        
        // Adds the screenshot to transition container
        container.addSubview(targetScreenshot)
        
        // Calculate a 3d transform to translate the screenshot back in Z plane
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = 1.0 / -1000.0
        perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 50, -300)
        
        // Applies the 3d transform to screenshot
        targetScreenshot.layer.transform = perspectiveTransform
        
        
        // Start appearance transition for source controller because UIKit does not remove views from hierarchy when transition finished
        source.beginAppearanceTransition(false, animated: true)
        
        
        // The transition begins...
        UIView.animateKeyframesWithDuration(duration, delay: 0.0, options: .CalculationModeCubic, animations: {() -> Void in
            
            // Set the keyframe 1
            UIView.addKeyframeWithRelativeStartTime(key1Start, relativeDuration: key1End, animations: {() -> Void in
                
                // The source screen gradually takes its place in the screen
                var sourceRect = source.view.frame
                sourceRect.origin.y = CGRectGetHeight(UIScreen.mainScreen().bounds)
                source.view.frame = sourceRect
            })
            
            // Set the keyframe 2
            UIView.addKeyframeWithRelativeStartTime(key2Start, relativeDuration: key2End, animations: {() -> Void in
                
                // Target screen gradually becomes get the initial 3d position
                targetScreenshot.layer.transform = CATransform3DIdentity
                
                // Adds an ajust value, to avoid issues with navigation bars
                targetScreenshot.center.y += CGFloat(navBarAjustValue)
            })
            
            }, completion: {(finished: Bool) -> Void in
                
                // The screenshot can be safely remove at this point
                targetScreenshot.removeFromSuperview()
                
                // Adds an ajust value, to avoid issues with navigation bars
                target.view.center.y += CGFloat(navBarAjustValue)
                
                // Removes the target screen
                container.addSubview(target.view)
                
                // Finish transition
                context.completeTransition(finished)
                
                // End appearance transition for source screen
                source.endAppearanceTransition()
        })
    }
    
    private func animationPop(context: UIViewControllerContextTransitioning) {
        
        // Extracts the conteiner for both screen while are animated...
        let container = context.containerView()
        
        // Extracts the screens involved in the transition
        let source = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let target = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        // Get the duration from above
        let duration = self.transitionDuration(context)
        
        // Calculates the ajust value when screen has a navigation bar or item added
        let navBarAjustValue:     CGFloat = source.navigationController!.navigationBar.frame.size.height + 20 // System Bar
        let navBarAjustValueHalf: CGFloat = navBarAjustValue / 2.0
        
        
        // Target screen is added to transition container
        container.addSubview(target.view)
        
        // Source screen is also added, but is pushed to the back
        container.addSubview(source.view)
        container.sendSubviewToBack(source.view)
        
        // Initial alpha values
        source.view.alpha = 1.0
        target.view.alpha = 0.2
        
        // Defines the points outside the screen to position the target screen
        var centerOffScreen = source.view.center
        centerOffScreen.y = centerOffScreen.y + (centerOffScreen.y / 2)
        
        // Moves the screen to that position
        target.view.center = centerOffScreen
        
        
        // The transition begins...
        UIView.animateWithDuration(duration, delay: 0.0, options: .CurveEaseIn, animations: {() -> Void in
            
            // The target gradually moves to the screen center
            target.view.center = source.view.center
            
            // Adds an ajust value, to avoid issues with navigation bars
            if let _ = target as? ScreenCategories {
                target.view.center.y -= navBarAjustValueHalf
            }
            
            // Source screen gradually becomes transparent
            source.view.alpha = 0.6
            
            // Source screen gradually becomes visible
            target.view.alpha = 1.0
            
            }, completion: {(finished: Bool) -> Void in
                
                // Removes the source screen
                container.addSubview(source.view)
                
                // The animation is over
                context.completeTransition(true)
        })
    }
}
