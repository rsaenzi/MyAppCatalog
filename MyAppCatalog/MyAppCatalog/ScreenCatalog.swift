//
//  ScreenCatalog.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class ScreenCatalog: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCellWithIdentifier("CellCatalog", forIndexPath: indexPath) as! CellCatalog
        
        cell.textLabel?.text = App.app.model.getCategories()[indexPath.row].name
        
        // Return the filled cell
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // Saves the selected category index
        App.app.model.selectedCategory = indexPath.row
        
        // Shows the screen App List
        let screen: ScreenAppList = App.app.views.loadScreen()
        self.navigationController?.pushViewController(screen, animated: true)
    }
}
