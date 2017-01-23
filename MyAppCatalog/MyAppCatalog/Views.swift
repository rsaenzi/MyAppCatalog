//
//  Views.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class Views {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    let lightGreen = UIColor(red: 197/255, green: 241/255, blue: 227/255, alpha: 1)
    let mediumBlue = UIColor(red:   1/255, green: 153/255, blue: 213/255, alpha: 1)
    
    
    // --------------------------------------------------
    // Public Methods
    // --------------------------------------------------
    func loadScreen<T: UIViewController>(screenClass: T.Type) -> T {
        
        // Get the screen name
        let name = className(screenClass)
        
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
    
    func loadNavController<T: UINavigationController>(navControllerClass: T.Type, rootScreen root: UIViewController) -> T {
        
        // Get the NavController name
        let name = className(navControllerClass)
        
        // Load Storyboard
        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        // Load NavController an cast it
        if let navController = storyboard.instantiateViewControllerWithIdentifier(name) as? T {
            
            // Set the root view controller
            navController.setViewControllers([root], animated: false)
            return navController
            
        }else {
            // Returns a default NavController
            return UINavigationController() as! T
        }
    }
    
    
    // --------------------------------------------------
    // Private Methods
    // --------------------------------------------------
    private func className(some: Any) -> String {
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
