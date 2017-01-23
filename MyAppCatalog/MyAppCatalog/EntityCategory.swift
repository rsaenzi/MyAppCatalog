//
//  EntityCategory.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import ObjectMapper

class EntityCategory: Mappable {
    
    // --------------------------------------------------
    // Data
    // --------------------------------------------------
    var id:   String?
    var name: String?
    var link: String?
    
    
    // --------------------------------------------------
    // Mappable
    // --------------------------------------------------
    
    // Keys
    private let idKey   = "id"
    private let nameKey = "label"
    private let linkKey = "scheme"
    
    func mapping(map: Map) {
        
        // Deserialize the fields
        id   <- map[idKey]
        name <- map[nameKey]
        link <- map[linkKey]
    }
    
    required init?(_ map: Map) {}
}
