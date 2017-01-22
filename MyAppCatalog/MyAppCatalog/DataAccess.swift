//
//  DataAccess.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class DataAccess {
    
    var catalog: ApiConnectCatalog = ApiConnectCatalog()!

    
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
