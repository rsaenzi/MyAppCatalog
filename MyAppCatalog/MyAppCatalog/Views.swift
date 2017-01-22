//
//  Views.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class Views {
    
    func loadScreen<T: UIViewController>() -> T {
        
        // Get the screen name
        let name = className(T)
        
        // Load Storyboard
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        // Load ViewController an cast it
        if let screen = storyboard.instantiateViewControllerWithIdentifier(name) as? T {
            return screen
            
        }else {
            // Returns a default screen
            return UIViewController() as! T
        }
    }
    
    func className(some: Any) -> String {
        return (some is Any.Type) ? "\(some)" : "\(some.dynamicType)"
    }
    
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if Views.instanceCreated == false {
            Views.instanceCreated = true
        }else{
            return nil
        }
    }
}
