//
//  BaseNavigationController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    // MARK: - Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        if let rootViewController = viewControllers.last {
            return rootViewController.preferredStatusBarStyle
        }
        return .default
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.style(Theme.View.primary)
        navigationBar.style(Theme.NavigationBar.primary)
    }
}
