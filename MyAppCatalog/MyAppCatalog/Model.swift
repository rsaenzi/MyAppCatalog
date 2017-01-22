//
//  Model.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class Model {
    
    // --------------------------------------------------
    // Components
    // --------------------------------------------------
    var catalog: EntityCatalog?
    
    
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if Model.instanceCreated == false {
            Model.instanceCreated = true
        }else{
            return nil
        }
    }
}
