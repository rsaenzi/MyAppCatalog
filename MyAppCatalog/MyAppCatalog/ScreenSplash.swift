//
//  ScreenSplash.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenSplash: UIViewController {
    
    @IBOutlet weak var imageLogo: UIImageView!
    
    private var ruleResult = RuleCatalogResult.offlineWithNoData
    private let duration: NSTimeInterval = 5.0
    
    private var apiCalled = false
    private var animEnded = false
    
    override func viewDidLoad() {
        
        apiCalled = false
        animEnded = false
        
        // Start the connection to API
        App.app.rules.catalog.start() { (result) in
            
            // Saves the result
            self.ruleResult = result
            
            self.apiCalled = true
            
            // Decides what to do next
            if self.apiCalled && self.animEnded {
                self.processResult()
            }
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let key1Start = 0.0
        let key1End   = 0.1
        
        let key2Start = 0.2
        let key2End   = 0.3
        
        self.imageLogo.transform = CGAffineTransformMakeScale(5.0, 5.0);
        self.imageLogo.alpha = 0
        
        // The animation begins...
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: .CalculationModeLinear, animations: {
            
            // Set the keyframe 1
            UIView.addKeyframeWithRelativeStartTime(key1Start, relativeDuration: key1End, animations: {
                self.imageLogo.transform = CGAffineTransformIdentity // MakeScale(1.0, 1.0);
                self.imageLogo.alpha = 1
            })
            
            // Set the keyframe 2
            UIView.addKeyframeWithRelativeStartTime(key2Start, relativeDuration: key2End, animations: {
                //self.imageLogo.transform = CGAffineTransformMakeScale(1.0, 1.0);
                
                self.imageLogo.frame.origin.y -= 100
            })
            
        }) { (finished) in
            
            self.animEnded = true
            
            // Decides what to do next
            if self.apiCalled && self.animEnded {
                self.processResult()
            }
        }
        
    }
    
    private func processResult(){
        
        switch self.ruleResult {
            
        case .online:
            
            // Shows the catalog screen
            self.showCatalog()
            
        case .offlineWithCachedData:
            
            // Create the OK button
            let alertActionOK = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) in
                self.showCatalog()
            })
            
            // Create and configure the alert
            let alert = UIAlertController(title: "Warning", message: "There is no Internet. A cached info will be displayed...", preferredStyle: .Alert)
            alert.addAction(alertActionOK)
            
            // Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
        case .offlineWithNoData:
            
            // Create the OK button
            let alertActionOK = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) in
            })
            
            // Create and configure the alert
            let alert = UIAlertController(title: "Error", message: "There is no Internet. No cached data is available...", preferredStyle: .Alert)
            alert.addAction(alertActionOK)
            
            // Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func showCatalog() {
        
        // Creates the screen
        let screen = App.app.views.loadScreen(ScreenCategories)
        
        // Place it in a navigation controller
        let navController = App.app.views.loadNavController(NavControlMain.self, rootScreen: screen)
        
        // Specify the animator for this transition
        let animator = AnimatorSplashToNavMain()
        navController.transitioningDelegate = animator
        
        // Set the delegate of navController as itself
        navController.delegate = navController
        
        // Request navigation controller to show its root view controller
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
}
