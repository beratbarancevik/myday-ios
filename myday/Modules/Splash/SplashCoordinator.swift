//
//  SplashCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class SplashCoordinator {
    // MARK: - Properties
    var window: UIWindow
    
    private let splashViewController: SplashViewController
    private let splashViewModel: SplashViewModel
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        splashViewModel = SplashViewModel()
        splashViewController = SplashViewController(viewModel: splashViewModel)
    }
    
    // MARK: - Functions
    func start() {
        window.rootViewController = splashViewController
    }
}
