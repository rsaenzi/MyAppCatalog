//
//  StringExtension.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import Foundation

extension String {
    
    func countOcurrences(stringToCount: String) -> Int {
        let slices = self.componentsSeparatedByString(stringToCount)
        return slices.count-1
    }
    
    func replace(string:String, replacement:String) -> String {
        return self.stringByReplacingOccurrencesOfString(string, withString: replacement, options: NSStringCompareOptions.LiteralSearch, range: nil)
    }
    
    func remove(toRemove: String) -> String {
        return self.replace(toRemove, replacement: "")
    }
    
    func removeSpaces() -> String {
        return self.replace(" ", replacement: "")
    }
    
    func contains(find: String) -> Bool{
        return self.rangeOfString(find) != nil
    }
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
}
