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
        
        // Load alert
        
        // Start the connection to API
        App.app.rules.catalog.start() { (success) in
            
            print("Rule Success: \(success)")
            
            // If the data could be obtained from the API
            if success == true {
                self.showCatalog()

            }else {
                
                // Create the OK button
                let alertActionOK = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) in
                    self.showCatalog()
                })
                
                // Create and configure the alert
                let alert = UIAlertController(title: "Info", message: "There is no Internet", preferredStyle: .Alert)
                alert.addAction(alertActionOK)
                
                // Display the alert
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func showCatalog() {
    
        // Creates the screen
        let screen: ScreenCatalog = App.app.views.loadScreen()
        
        // Place it in a navigation controller
        let navController: NavControlMain = App.app.views.loadNavController(rootScreen: screen)
        
        // Request navigation controller to show its root view controller
        self.presentViewController(navController, animated: true, completion: nil)
    }
    
}
