//
//  ScreenAppInfo.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenAppInfo: UIViewController {
    
    
    override func viewDidLoad() {
        
        // Set the screen title
        self.navigationItem.title = App.app.model.getSelectedApp().name
    }
}
