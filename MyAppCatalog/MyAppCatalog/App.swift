//
//  App.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

class App {
    
    // --------------------------------------------------
    // Components
    // --------------------------------------------------
    var model: Model         = Model()!
    var views: Views         = Views()!
    var data : DataAccess    = DataAccess()!
    var rules: BusinessRules = BusinessRules()!

    
    // --------------------------------------------------
    // Singleton
    // --------------------------------------------------
    static let app = App()
    private init() {}
}
