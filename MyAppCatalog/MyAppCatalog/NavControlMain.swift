//
//  NavControlMain.swift
//  MyAppCatalog
//
//  Created by Rigoberto Sáenz Imbacuán [https://www.linkedin.com/in/rsaenzi] on 1/22/17.
//  Copyright © 2017 Rigoberto Sáenz Imbacuán. All rights reserved.
//

import UIKit

class NavControlMain: UINavigationController, UINavigationControllerDelegate {
    
    // --------------------------------------------------
    // Members
    // --------------------------------------------------
    private let animator = AnimatorNavControllerMain()
    

    // --------------------------------------------------
    // UINavigationControllerDelegate
    // --------------------------------------------------
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // Set the operation that will be perform in the animator
        animator.operation = operation
        
        // Set the animator that will handle animated transitions
        return animator
    }
}
