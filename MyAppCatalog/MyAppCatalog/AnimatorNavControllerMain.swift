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
    
    var operation = UINavigationControllerOperation.Pop
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        switch operation {
        case .Pop: return 1.0
        default:   return 1.0
        }
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        switch operation {
        case .Pop: animationPop(transitionContext)
        default:   animationPush(transitionContext)
        }
    }
    
    private func animationPush(context: UIViewControllerContextTransitioning) {
        
        // Extracts the conteiner for both screen while are animated...
        let container = context.containerView()
        
        // Extracts the screens involved in the transition
        let source = context.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let target = context.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        // Get the duration from above
        let duration = self.transitionDuration(context)
        
        // Calculate the dependant values
        let keyframe1Start    = duration * 0.0
        let keyframe2Start    = duration * 0.2
        let keyframe1Relative = duration * 1.0
        let keyframe2Relative = duration * 0.8
        
        // Calculates the ajust value when screen has a navigation bar or item added
        let navBarAjustValue: CGFloat = source.navigationController!.navigationBar.frame.size.height + 20 // System Bar
        
        
        // Takes a screenshot of target screen
        let targetScreenshot = target.view.snapshotViewAfterScreenUpdates(true)!
        
        // Adds the screenshot to transition container
        container.addSubview(targetScreenshot)
        
        // Calculate a 3d transform to translate the screenshot back in Z plane
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = 1.0 / -1000.0
        perspectiveTransform = CATransform3DTranslate(perspectiveTransform, 0, 0, -100)
        
        // Applies the 3d transform to screenshot
        targetScreenshot.layer.transform = perspectiveTransform
        
        
        // Start appearance transition for source controller because UIKit does not remove views from hierarchy when transition finished
        source.beginAppearanceTransition(false, animated: true)
        
        
        // The transition begins...
        UIView.animateKeyframesWithDuration(duration, delay: 0.0, options: .CalculationModeCubic, animations: {() -> Void in
            
            // Set an animation keyframe
            UIView.addKeyframeWithRelativeStartTime(keyframe1Start, relativeDuration: keyframe1Relative, animations: {() -> Void in
                
                // The source screen gradually takes its place in the screen
                var sourceRect = source.view.frame
                sourceRect.origin.y = CGRectGetHeight(UIScreen.mainScreen().bounds)
                source.view.frame = sourceRect
            })
            
            // Set another animation keyframe
            UIView.addKeyframeWithRelativeStartTime(keyframe2Start, relativeDuration: keyframe2Relative, animations: {() -> Void in
                
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
                
                // Add destination controller to view
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
        
        // Calculate the dependant values
        let damping = CGFloat(duration) * 1.0
        let sprint  = CGFloat(duration) * 3.0
        
        // Calculates the ajust value when screen has a navigation bar or item added
        let navBarAjustValue:     CGFloat = source.navigationController!.navigationBar.frame.size.height + 20 // System Bar
        let navBarAjustValueHalf: CGFloat = navBarAjustValue / 2.0
        
        
        // Target screen is added to transition container
        container.addSubview(target.view)
        
        // Defines the points outside the screen to position the target screen
        var centerOffScreen = container.center
        centerOffScreen.y = (-1) * container.frame.size.height
        
        // Moves the screen to that position
        target.view.center = centerOffScreen
        
        
        // The transition begins...
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: damping, initialSpringVelocity: sprint, options: .CurveEaseIn, animations: {() -> Void in
            
            // The target gradually moves to the screen center
            target.view.center = container.center
            
            // Adds an ajust value, to avoid issues with navigation bars
            if let _ = target as? ScreenCategories {
                target.view.center.y += navBarAjustValueHalf
            }else {
                target.view.center.y += navBarAjustValue
            }
            
            // Source screen gradually becomes transparent
            source.view.alpha = 0
            
            }, completion: {(finished: Bool) -> Void in
                
                // The animation is over
                context.completeTransition(true)
        })
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
