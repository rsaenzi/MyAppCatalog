//
//  ScreenCategoriesIpad.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/23/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenCategoriesIpad: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    @IBOutlet weak var collectionview: UICollectionView!
    private let selection = UIView()
    private let iconCorner: CGFloat = 25.0
    private let cellIdentifier = "CellCategoriesIpad"
    
    
    // --------------------------------------------------
    // UIViewController
    // --------------------------------------------------
    override func viewDidLoad() {
        
        // Set the selection color
        selection.backgroundColor = App.app.views.lightGreen
    }
    
    
    // --------------------------------------------------
    // UICollectionViewDataSource
    // --------------------------------------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return App.app.model.getCategories().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        // Dequeue a cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CellCategoriesIpad
        
        // Get the category to display
        let category = App.app.model.getCategories()[indexPath.row]
        let apps     = App.app.model.getApps(categoryIndex: indexPath.row)
        
        // Fill in the cell
        cell.name.text     = category.name
        cell.appCount.text = "Apps: \(apps.count)"
        
        // Shows the icon
        if let imageLink = apps[0].imageUrl {
            
            // Loads image from cache, if does not exist, start the download
            cell.iconImg.kf_setImageWithURL(NSURL(string: imageLink))
        }
        
        // Adds a round border to imageview
        if cell.iconImg.layer.cornerRadius != iconCorner {
            cell.iconImg.layer.cornerRadius = iconCorner
        }
 
        // Set the selection color
        cell.selectedBackgroundView = selection
        
        
        // Return the filled cell
        return cell
    }
    
    
    // --------------------------------------------------
    // UICollectionViewDelegate
    // --------------------------------------------------
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
        // Saves the selected category index
        App.app.model.selectedCategory = indexPath.row
        
        // Shows the screen App List
        let screen = App.app.views.loadScreen(ScreenAppListIpad)
        self.navigationController?.pushViewController(screen, animated: true)
        
        // Clears the selection
        collectionview.deselectItemAtIndexPath(indexPath, animated: true)
    }
    
    
    // --------------------------------------------------
    // IBAction
    // --------------------------------------------------
    @IBAction func onTapIcon(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.linkedin.com/in/rsaenzi/")!)
    }
}
