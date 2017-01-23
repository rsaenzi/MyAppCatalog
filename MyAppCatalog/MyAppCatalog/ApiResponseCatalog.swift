//
//  ApiResponseCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class ApiResponseCatalog {
    
    // Status
    var code      = ApiCodeCatalog.noInternet
    
    // Data
    var catalog   : EntityCatalog?
    var jsonString: String?
}
