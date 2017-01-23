//
//  ScreenAppListIpad.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/23/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenAppListIpad: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    @IBOutlet weak var collectionview: UICollectionView!
    private let selection = UIView()
    private let iconCorner: CGFloat = 25.0
    private let cellIdentifier = "CellAppListIpad"
    
    
    // --------------------------------------------------
    // UIViewController
    // --------------------------------------------------
    override func viewDidLoad() {
        
        // Set the screen title
        self.navigationItem.title = App.app.model.getSelectedCategory().name
        
        // Set the selection color
        selection.backgroundColor = App.app.views.lightGreen
    }
    
    
    // --------------------------------------------------
    // UICollectionViewDataSource
    // --------------------------------------------------
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return App.app.model.getAppsFromSelectedCategory().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
        // Dequeue a cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! CellAppListIpad
        
        // Get the app to display
        let app = App.app.model.getAppsFromSelectedCategory()[indexPath.row]
        
        // Fill in the cell
        cell.name.text       = app.name
        cell.artistName.text = app.artistName
        cell.date.text       = app.releaseDate
        
        // Shows the price
        if let priceString = app.price {
            
            // If price is zero, shows the label Free
            if let price = Double(priceString) where price > 0 {
                cell.price.text = "\(price) \(app.currency!)"
            }else {
                cell.price.text = "Free"
            }
        }else {
            cell.price.text = "-"
        }
        
        // Shows the icon
        if let imageLink = app.imageUrl {
            
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
    
        // Saves the selected app index
        App.app.model.selectedApp = indexPath.row
        
        // Shows the screen App Info
        let screen = App.app.views.loadScreen(ScreenAppInfo)
        self.navigationController?.pushViewController(screen, animated: true)
        
        // Clears the selection
        collectionview.deselectItemAtIndexPath(indexPath, animated: true)
    }
}
