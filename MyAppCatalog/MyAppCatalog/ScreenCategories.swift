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
    
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        
        // Deletes the empty cells of the table
        tableview.tableFooterView = UIView(frame: CGRectZero)
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.app.model.getCategories().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Dequeue a cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellCategories", forIndexPath: indexPath) as! CellCategories
        
        // Get the category to display
        let category = App.app.model.getCategories()[indexPath.row]
        let apps     = App.app.model.getApps(categoryIndex: indexPath.row)
        
        // Fill in the cell
        cell.name.text     = category.name
        cell.appCount.text = "Apps: \(apps.count)"
        
        if let imageLink = apps[0].imageUrl {
            cell.icon.kf_setImageWithURL(NSURL(string: imageLink))
        }
        
        // Return the filled cell
        return cell
    }
    
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
