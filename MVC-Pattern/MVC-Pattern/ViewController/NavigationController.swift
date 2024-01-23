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
        let viewControllerToPush = CategoriesViewController()
        pushViewController(viewControllerToPush, animated: false)
        setViewControllers([viewControllerToPush], animated: false)
    }
}
