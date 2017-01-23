//
//  DataAccess.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class DataAccess {
    
    // --------------------------------------------------
    // Components
    // --------------------------------------------------
    var apiConnection: ApiConnectCatalog  = ApiConnectCatalog()!
    var persistence:   PersistenceCatalog = PersistenceCatalog()!

    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if DataAccess.instanceCreated == false {
            DataAccess.instanceCreated = true
        }else{
            return nil
        }
    }
}
