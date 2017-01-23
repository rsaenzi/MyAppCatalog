//
//  ScreenSplash.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenSplash: UIViewController {
    
    override func viewDidLoad() {
    
        // TODO: Temporal
        let triggerTime = Int64(NSEC_PER_SEC) * 1
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
        
            // Start the connection to API
            App.app.rules.catalog.start() { (ruleResult) in
                
                // Decides what to do next
                self.processResult(ruleResult)
            }
        })
    }
    
    private func processResult(ruleResult: RuleCatalogResult){
    
        // TODO: Temporal
        let triggerTime = Int64(NSEC_PER_SEC) * 2
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
            
            switch ruleResult {
            
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
        })
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
