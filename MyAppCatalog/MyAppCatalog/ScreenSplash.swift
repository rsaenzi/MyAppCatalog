//
//  ScreenSplash.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Foundation

class ScreenSplash: UIViewController {
    
    override func viewDidLoad() {
        
        // Load alert
        
        // Start the connection to API
        App.app.rules.catalog.start() { (success) in
            
            print("Rule Success: \(success)")
            
            let screen: ScreenCatalog = App.app.views.loadScreen()
            self.presentViewController(screen, animated: true, completion: {
                
            })
            
        }
    }
    
}
