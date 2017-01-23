//
//  ScreenAppInfo.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/21/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit
import Foundation

class ScreenAppInfo: UIViewController {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var iconImg: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var iTunesId: UILabel!
    @IBOutlet weak var iTunesLink: UILabel!
    @IBOutlet weak var bundleId: UILabel!
    @IBOutlet weak var artistLink: UILabel!
    @IBOutlet weak var copyright: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var buttonAppStore: UIButton!
    
    @IBOutlet weak var scrollContentHeight: NSLayoutConstraint!
    @IBOutlet weak var panelDockedHeight: NSLayoutConstraint!
    
    private let iconCorner:       CGFloat = 12.0
    private let buttonCorner:     CGFloat = 5.0
    private let iPadTextAjust:    CGFloat = 0.7
    private let panelDockedClose: CGFloat = 80.0
    private let panelDockedOpen:  CGFloat = 140.0
    private let panelDockedSpeed: NSTimeInterval = 0.5
    
    override func viewDidLoad() {
        
        // Get the app to display
        let app = App.app.model.getSelectedApp()
        
        // Fill in the cell
        name.text       = app.name
        artistName.text = app.artistName
        date.text       = app.releaseDate
        iTunesId.text   = app.itunesId
        iTunesLink.text = app.itunesLink
        bundleId.text   = app.bundleId
        artistLink.text = app.artistLink
        copyright.text  = app.copyright
        summary.text    = app.summary

        // Shows the price
        if let priceString = app.price {
            
            // If price is zero, shows the label Free
            if let priceValue = Double(priceString) where priceValue > 0 {
                price.text = "\(priceValue) \(app.currency!)"
            }else {
                price.text = "Free"
            }
        }else {
            price.text = "-"
        }
        
        // Shows the icon
        if let imageLink = app.imageUrl {
            
            // Loads image from cache, if does not exist, start the download
            iconImg.kf_setImageWithURL(NSURL(string: imageLink))
        }
        
        // Adds a round border to imageview
        if iconImg.layer.cornerRadius != iconCorner {
            iconImg.layer.cornerRadius = iconCorner
        }
        
        // Request the UIlabel to calculate its new size using the new text added before
        summary.sizeToFit()

        // Calculate the text lines that are necessary to add, in order to show the whole label content
        var pixelsToAdd: CGFloat = summary.frame.size.height
        
        // Text size ajustment for iPad
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            pixelsToAdd *= iPadTextAjust
        }
        
        // Adds the pixels to the content view inside scroll
        scrollContentHeight.constant += pixelsToAdd
        
        // Adds a round corner
        buttonAppStore.layer.cornerRadius = buttonCorner
        
        // Set the initial size of panelDocked
        panelDockedHeight.constant = panelDockedClose
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Expands panelDocked
        panelDockedHeight.constant = panelDockedOpen
        
        // Animates the size change
        UIView.animateWithDuration(panelDockedSpeed, delay: 0, options: .CurveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
    
    @IBAction func onTapButton(sender: UIButton, forEvent event: UIEvent) {
        
        // Get the current app
        let app = App.app.model.getSelectedApp()
        
        // Open the URL
        UIApplication.sharedApplication().openURL(NSURL(string: app.itunesLink!)!)
    }
    
    
}
