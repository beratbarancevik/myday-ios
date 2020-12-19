//
//  ApplicationCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let window: UIWindow
    private let homeCoordinator: HomeCoordinator
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        navigationController = BaseNavigationController()
        homeCoordinator = HomeCoordinator(presenter: navigationController)
    }
    
    // MARK: - Coordinator
    func start() {
        window.rootViewController = navigationController
        homeCoordinator.start()
        window.makeKeyAndVisible()
    }
}
