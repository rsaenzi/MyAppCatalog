//
//  RuleCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

typealias CallbackRuleCatalog = (result: RuleCatalogResult) -> ()

class RuleCatalog {
    
    // --------------------------------------------------
    // Public Methods
    // --------------------------------------------------
    func start(callback: CallbackRuleCatalog) {
        
        // First we try to get the data from the API
        App.app.data.apiConnection.get{ (response) in
            
            // If connection was successful, and the catalog exist
            if let catalog = response.catalog where response.code == .success {
                
                // Saves the info in the Model
                App.app.model.saveCatalog(catalog, canPrefecthImages: true)
                
                // Persist the json to rebuild the catalog later if needed
                if let data = response.jsonString {
                    App.app.data.persistence.save(data)
                }
                
                // Informs the result
                callback(result: .online)
                
            }else {
                
                // Asks if a previous catalog was download
                let readData = App.app.data.persistence.read()
                
                // If any data was obtained
                if let validData = readData {
                    
                    // Parse the entities from the Json string
                    if let catalog = EntityCatalog(JSONString: validData) {
                        
                        // Saves the info in the Model
                        App.app.model.saveCatalog(catalog, canPrefecthImages: false)
                        
                        // Informs the result
                        callback(result: .offlineWithCachedData)
                        
                    }else {
                        
                        // Informs the result
                        callback(result: .offlineWithNoData)
                    }
                }else {
                    
                    // Informs the result
                    callback(result: .offlineWithNoData)
                }
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
