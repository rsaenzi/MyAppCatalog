//
//  PersistenceStorable.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán on 1/23/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import SwiftyDB

class PersistenceStorable: NSObject, Storable {
    
    var data = String()
    
    required override init() {}
}
