//
//  RuleCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

typealias CallbackRuleCatalog = (success: Bool) -> ()

class RuleCatalog {
    
    func start(callback: CallbackRuleCatalog) {
        
        App.app.data.catalog.get{ (response) in
            
            print("Response Code: \(response.code)")
            
            // If connection was successful, and the catalog exist
            if let catalog = response.catalog where response.code == .success {
                
                // Saves the info in the Model
                App.app.model.saveCatalog(catalog)
                
                // Informs the result
                callback(success: true)
                
            }else {
                
                // Informs the result
                callback(success: false)
            }
        }
    }
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if RuleCatalog.instanceCreated == false {
            RuleCatalog.instanceCreated = true
        }else{
            return nil
        }
    }
}
