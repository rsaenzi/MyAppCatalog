//
//  Model.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Kingfisher

class Model {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    private var categories:     [EntityCategory]?
    private var appsByCategory: [Int: [EntityApp]]?
    
    var selectedCategory: Int = 0
    var selectedApp:      Int = 0
    
    
    // --------------------------------------------------
    // Public Methods
    // --------------------------------------------------
    func saveCatalog(catalog: EntityCatalog, canPrefecthImages: Bool) {
        
        // Prefetch and saves app icons
        if let allApps = catalog.apps where canPrefecthImages == true {
            prefecthImages(allApps)
        }
        
        // Extract the categories avoiding duplicates
        var extractedCategories = [String : EntityCategory]()
        
        // If the catalog has any apps
        if let allApps = catalog.apps {
            for app in allApps {
             
                // If the app has a category
                if let category = app.category {
                    if let id = category.id {
                        
                        // Extracts the category. Dictionary takes care of duplicates
                        extractedCategories[id] = category
                    }
                }
            }
        }
        
        // Finally saves the categories
        categories = extractedCategories.map{$1}
        
        
        // Now we filter the applications by category
        appsByCategory = [:]
        
        // Loops through all categories
        for (categoryIndex, categoryToTest) in categories!.enumerate() {
            
            // Loop through the apps
            if let allApps = catalog.apps {
                
                // Filter the apps tha belongs to the current category
                let appsForCategory: [EntityApp] = allApps.filter({$0.category!.id == categoryToTest.id})
                
                // Adds the apps to right position in application dictionary
                appsByCategory?[categoryIndex] = appsForCategory
            }
        }
        
        // Reset the indexes
        selectedCategory = 0
        selectedApp      = 0
    }
    
    func getSelectedCategory() -> EntityCategory {
        return getCategories()[selectedCategory]
    }
    
    func getCategories() -> [EntityCategory] {
        if let list = categories {
            return list
        }else {
            return []
        }
    }
    
    func getSelectedApp() -> EntityApp {
        return getAppsFromSelectedCategory()[selectedApp]
    }
    
    func getApps(categoryIndex index: Int) -> [EntityApp] {
        if let apps = appsByCategory?[index] {
            return apps
        }else {
            return []
        }
    }
    
    func getAppsFromSelectedCategory() -> [EntityApp] {
        if let apps = appsByCategory?[selectedCategory] {
            return apps
        }else {
            return []
        }
    }
    
    
    // --------------------------------------------------
    // Private Methods
    // --------------------------------------------------
    private func prefecthImages(allApps: [EntityApp]) {
        
        // Gets all image url
        var imageURLs: [NSURL] = []
        for app in allApps {
            
            // If the image url exist and is valid
            if let url: String = app.imageUrl {
                if let validURL: NSURL = NSURL(string: url) {
                    
                    // It is added to list of images to be prefetched
                    imageURLs.append(validURL)
                }
            }
        }
        
        // Creates and runs the prefetcher
        let prefetcher = ImagePrefetcher(urls: imageURLs)
        prefetcher.start()
    }
    
    
    // --------------------------------------------------
    // Unique-Access Singleton
    // --------------------------------------------------
    private static var instanceCreated = false
    
    required init?() {
        if Model.instanceCreated == false {
            Model.instanceCreated = true
        }else{
            return nil
        }
    }
}
