//
//  ApplicationCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import UIKit

class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let window: UIWindow
    private var splashCoordinator: SplashCoordinator?
    private var tabCoordinator: TabCoordinator?
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        splashCoordinator = SplashCoordinator(window: window)
        addAuthenticationObserver()
    }
    
    // MARK: - Coordinator
    func start() {
        splashCoordinator?.start()
        window.makeKeyAndVisible()
    }
    
    func showMain() {
        tabCoordinator = TabCoordinator(window: window)
        tabCoordinator?.start()
        splashCoordinator = nil
    }
}

// MARK: - Private Functions
private extension ApplicationCoordinator {
    func addAuthenticationObserver() {
        cancellable = AuthenticationManager.shared.authDidCompleteSubject.sink { [weak self] _ in
            #if DEBUG
            // makes sure that splash screen's UI gets tested
            if ProcessInfo.processInfo.environment["ShouldStopAtSplash"] == "YES" {
                print("UI tests are running for Splash screen")
                return
            }
            #endif
            self?.showMain()
            self?.cancellable?.cancel()
        }
    }
}
