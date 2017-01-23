//
//  ScreenSplash.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenSplash: UIViewController {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var textTitle: UILabel!
    @IBOutlet weak var textAppName: UILabel!
    @IBOutlet weak var textAuthor: UILabel!
    @IBOutlet weak var panelInfo: UIView!
    @IBOutlet weak var panelInfoHeight: NSLayoutConstraint!
    @IBOutlet weak var textStatus: UILabel!
    
    private var ruleResult = RuleCatalogResult.offlineWithNoData
    private let duration: NSTimeInterval = 4.0
    private let panelInfoHeightOpen: CGFloat = 70.0
    
    // Flags to determine if catalog screen can be shown
    private var apiCalled = false
    private var animEnded = false
    
    
    // --------------------------------------------------
    // UIViewController
    // --------------------------------------------------
    override func viewDidLoad() {
        
        // Initial state of flags
        apiCalled = false
        animEnded = false
        
        // Set the initial values of image logo
        imageLogo.transform = CGAffineTransformMakeScale(5.0, 5.0);
        imageLogo.alpha = 0
        
        // Set the initial alpha for texts
        textTitle.alpha   = 0
        textAppName.alpha = 0
        textAuthor.alpha  = 0
        
        // Default height of panel info
        panelInfoHeight.constant = 0
        
        // Starts a connection to the API
        startConnection()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Initial state of flag
        animEnded = false
        
        // The animation begins...
        animationStep1()
    }
    
    
    // --------------------------------------------------
    // Private Methods
    // --------------------------------------------------
    private func startConnection() {
        
        // Initial state of flag
        apiCalled = false
    
        // Start the connection to API
        App.app.rules.catalog.start() { (result) in
            
            // Saves the result
            self.ruleResult = result
            
            // This api call has ended, so we rise the flag
            self.apiCalled = true
            
            // Decides we it is time to show the catalog screen
            if self.apiCalled && self.animEnded {
                self.processResult()
            }
        }
    }
    
    private func animationStep1() {
        
        UIView.animateWithDuration(1, animations: {
            
            // Image logo gradually gets its final size and alpha
            self.imageLogo.transform = CGAffineTransformIdentity
            self.imageLogo.alpha = 1
            
        }) { (finished) in
            self.animationStep2()
        }
    }
    
    private func animationStep2() {
        UIView.animateWithDuration(1, animations: {
            
            self.textTitle.alpha = 1
            
        }) { (finished) in
            self.animationStep3()
        }
    }
    
    private func animationStep3() {
        UIView.animateWithDuration(1, animations: {
            
            self.textAppName.alpha = 1
            self.textAuthor.alpha  = 1
            
        }) { (finished) in
            self.animationStep4()
        }
    }
    
    private func animationStep4() {
        
        // Change the size
        self.panelInfoHeight.constant = self.panelInfoHeightOpen
        
        // Animates the size change
        UIView.animateWithDuration(1, delay: 0, options: .CurveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            
        }) { (finished) in
            
            let triggerTime = (Int64(NSEC_PER_SEC) * 1)
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, triggerTime), dispatch_get_main_queue(), { () -> Void in
                
                // This animation has ended, so we rise the flag
                self.animEnded = true
                
                // Decides we it is time to show the catalog screen
                if self.apiCalled && self.animEnded {
                    self.processResult()
                }
            })
        }
    }
    
    private func processResult(){
        
        // We act according to rule result
        switch self.ruleResult {
            
        case .online:
            resultOnline()
            
        case .offlineWithCachedData:
            resultOfflineWithCachedData()
            
        case .offlineWithNoData:
            resultOfflineWithNoData()
        }
    }
    
    private func resultOnline() {
    
        // Set the status
        textStatus.text = "Online"
        
        // Animates the text change
        UIView.transitionWithView(textStatus, duration: 0.2, options: .TransitionFlipFromBottom, animations: nil, completion: nil)
        
        UIView.animateWithDuration(1, animations: {
            self.panelInfo.backgroundColor = UIColor.greenColor()
            
        }) { (finished) in
            
            // Shows the catalog screen
            self.showCatalog()
        }
    }
    
    private func resultOfflineWithCachedData() {
        
        // Set the status
        textStatus.text = "Offline (Cache Data Available)"
        
        // Animates the text change
        UIView.transitionWithView(textStatus, duration: 0.2, options: .TransitionFlipFromBottom, animations: nil, completion: nil)
    
        UIView.animateWithDuration(1, animations: {
            self.panelInfo.backgroundColor = UIColor.orangeColor()
            
        }) { (finished) in
            
            // Create the OK button
            let alertActionOK = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) in
                self.showCatalog()
            })
            
            // Create and configure the alert
            let alert = UIAlertController(title: "Warning", message: "You are offline. A cached app list will be displayed...", preferredStyle: .Alert)
            alert.addAction(alertActionOK)
            
            // Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func resultOfflineWithNoData() {
        
        // Set the status
        textStatus.text = "Offline (No data available)"
        
        // Animates the text change
        UIView.transitionWithView(textStatus, duration: 0.2, options: .TransitionFlipFromBottom, animations: nil, completion: nil)
        
        UIView.animateWithDuration(1, animations: {
            self.panelInfo.backgroundColor = UIColor.redColor()
            
        }) { (finished) in
            
            // Create the OK button
            let alertActionOK = UIAlertAction(title: "Try Again", style: .Default, handler: { (alertAction) in
                
                // Set the status
                self.textStatus.text = "Connecting..."
                
                // Animates the text change
                UIView.transitionWithView(self.textStatus, duration: 0.2, options: .TransitionFlipFromBottom, animations: nil, completion: nil)
                
                UIView.animateWithDuration(1, animations: {
                    self.panelInfo.backgroundColor = App.app.views.mediumBlue
                    
                }) { (finished) in
                    
                    // Starts a connection to the API
                    self.startConnection()
                }
            })
            
            // Create and configure the alert
            let alert = UIAlertController(title: "Error", message: "You are offline. No cached data is available.", preferredStyle: .Alert)
            alert.addAction(alertActionOK)
            
            // Display the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    private func showCatalog() {
        
        // Creates the screen
        var screen: UIViewController
        
        // The interface is different according to device type
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            screen = App.app.views.loadScreen(ScreenCategoriesIpad)
        }else {
            screen = App.app.views.loadScreen(ScreenCategories)
        }
        
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
