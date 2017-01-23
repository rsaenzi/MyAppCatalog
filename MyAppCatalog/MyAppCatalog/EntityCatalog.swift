//
//  EntityCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import ObjectMapper

class EntityCatalog: Mappable {
    
    // --------------------------------------------------
    // Data
    // --------------------------------------------------
    var name:       String?
    var updateDate: String?
    var copyright:  String?
    var apps:       Array<EntityApp>?
    
    
    // --------------------------------------------------
    // Mappable
    // --------------------------------------------------
    
    // Keys
    private let nameKey       = "feed.title.label"
    private let updateDateKey = "feed.updated.label"
    private let copyrightKey  = "feed.rights.label"
    private let appsKey       = "feed.entry"
    
    func mapping(map: Map) {
        
        // Deserialize the fields
        name       <- map[nameKey]
        updateDate <- map[updateDateKey]
        copyright  <- map[copyrightKey]
        apps       <- map[appsKey]
    }
    
    required init?(_ map: Map) {}
}
