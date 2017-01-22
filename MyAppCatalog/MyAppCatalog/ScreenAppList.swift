//
//  ScreenAppList.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenAppList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableview: UITableView!
    private let selection = UIView()
    
    override func viewDidLoad() {
        
        // Set the screen title
        self.navigationItem.title = App.app.model.getSelectedCategory().name
    
        // Deletes the empty cells of the table
        tableview.tableFooterView = UIView(frame: CGRectZero)
        
        // Set the selection color
        selection.backgroundColor = App.app.views.lightGreen
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.app.model.getAppsFromSelectedCategory().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Dequeue a cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellAppList", forIndexPath: indexPath) as! CellAppList
        
        // Get the apps to display
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
            cell.iconImg.kf_setImageWithURL(NSURL(string: imageLink))
        }
        
        // Adds a round border to imageview
        if cell.iconImg.layer.cornerRadius != 12 {
            cell.iconImg.layer.cornerRadius = 12
        }
        
        // Set the selection color
        cell.selectedBackgroundView = selection
        
        // Return the filled cell
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Saves the selected app index
        App.app.model.selectedApp = indexPath.row
        
        // Shows the screen App Info
        let screen = App.app.views.loadScreen(ScreenAppInfo)
        self.navigationController?.pushViewController(screen, animated: true)
        
        // Clears the selection
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
