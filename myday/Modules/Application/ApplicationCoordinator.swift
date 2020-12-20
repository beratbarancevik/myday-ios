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
    private let splashCoordinator: SplashCoordinator
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        navigationController = BaseNavigationController()
        homeCoordinator = HomeCoordinator(navigationController: navigationController)
        splashCoordinator = SplashCoordinator(window: window)
    }
    
    // MARK: - Coordinator
    func start() {
        splashCoordinator.start()
        window.makeKeyAndVisible()
    }
    
    func showHome() {
        window.rootViewController = navigationController
        homeCoordinator.start()
    }
}
