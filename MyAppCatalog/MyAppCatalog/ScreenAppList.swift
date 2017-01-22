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
    
    override func viewDidLoad() {
        
        // Set the screen title
        self.navigationItem.title = App.app.model.getSelectedCategory().name
    
        // Deletes the empty cells of the table
        tableview.tableFooterView = UIView(frame: CGRectZero)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.app.model.getAppsFromSelectedCategory().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Dequeue a cell
        let cell = tableView.dequeueReusableCellWithIdentifier("CellAppList", forIndexPath: indexPath) as! CellAppList
    
        cell.textLabel?.text = App.app.model.getAppsFromSelectedCategory()[indexPath.row].name
        
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
