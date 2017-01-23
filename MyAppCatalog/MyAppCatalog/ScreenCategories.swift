//
//  ScreenCategories.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Kingfisher

class ScreenCategories: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    @IBOutlet weak var tableview: UITableView!
    private let selection = UIView()
    private let iconCorner: CGFloat = 18.0
    private let cellIdentifier = "CellCategories"
    
    
    // --------------------------------------------------
    // UIViewController
    // --------------------------------------------------
    override func viewDidLoad() {
        
        // Deletes the empty cells of the table
        tableview.tableFooterView = UIView(frame: CGRectZero)
        
        // Set the selection color
        selection.backgroundColor = App.app.views.lightGreen
    }
    
    
    // --------------------------------------------------
    // UITableViewDataSource
    // --------------------------------------------------
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.app.model.getCategories().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Dequeue a cell
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! CellCategories
        
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
    // UITableViewDelegate
    // --------------------------------------------------
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Saves the selected category index
        App.app.model.selectedCategory = indexPath.row
        
        // Shows the screen App List
        let screen = App.app.views.loadScreen(ScreenAppList)
        self.navigationController?.pushViewController(screen, animated: true)
        
        // Clears the selection
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
