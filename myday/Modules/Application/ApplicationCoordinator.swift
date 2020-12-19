//
//  ApplicationCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let window: UIWindow
    private let rootViewController: BaseNavigationController
    private let homeCoordinator: HomeCoordinator
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        rootViewController = BaseNavigationController()
        homeCoordinator = HomeCoordinator(presenter: rootViewController)
    }
    
    // MARK: - Coordinator
    func start() {
        window.rootViewController = rootViewController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
