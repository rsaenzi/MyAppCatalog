//
//  PersistenceCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán on 1/23/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import SwiftyDB
import Foundation

class PersistenceCatalog {
    
    private let dbName  = "Catalog"
    private let dbField = "data"
    
    func save(data: String) -> Bool{
        
        // Empty data is not allowed
        if data.characters.count == 0 {
            return false
        }
        
        // Creates a storable object
        let storable = PersistenceStorable()
        storable.data = data
        
        // Open a database. It is created if do not exist...
        let database = SwiftyDB(databaseName: dbName)
        
        // Saves the storable, overriding any previous value
        database.addObject(storable, update: true)
        return true
    }
    
    func read() -> String? {
    
        // Open a database. It is created if do not exist...
        let database = SwiftyDB(databaseName: dbName)
        
        // Asks the database for the saved data
        let result = database.dataForType(PersistenceStorable.self)
        
        // if any data was obtained
        if let rawData = result.value {
            
            // No data available
            if rawData.count == 0 {
                return nil
            }
            
            // Get the stored object
            let storableContent = rawData[0]
            
            // Get the field data if possible...
            if let data = storableContent[dbField] as? String {
                return data
            }else {
                return nil
            }
        }else {
            
            // No data obtained
            return nil
        }
    }
    
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if PersistenceCatalog.instanceCreated == false {
            PersistenceCatalog.instanceCreated = true
        }else{
            return nil
        }
    }
}
