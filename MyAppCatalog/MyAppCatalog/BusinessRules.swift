//
//  BusinessRules.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class BusinessRules {
    
    // --------------------------------------------------
    // Components
    // --------------------------------------------------
    
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if BusinessRules.instanceCreated == false {
            BusinessRules.instanceCreated = true
        }else{
            return nil
        }
    }
}
