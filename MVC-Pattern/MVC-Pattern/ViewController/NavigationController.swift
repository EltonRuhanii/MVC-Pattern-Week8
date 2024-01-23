//
//  NavigationController.swift
//  Week8-MVCPattern
//
//  Created by @EltonRuhani Kin+Carta on 22.1.24.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Example: Push a view controller and make it the root
        let viewControllerToPush = ViewController() // Replace with your actual view controller class
        pushViewController(viewControllerToPush, animated: false)
        setViewControllers([viewControllerToPush], animated: false)
    }
}
