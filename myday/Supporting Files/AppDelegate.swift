//
//  AppDelegate.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Firebase
import SnapKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?
    
    // MARK: - App Delegate Functions
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp()
        startApp()
        return true
    }
}

// MARK: - Private Functions
private extension AppDelegate {
    func configureApp() {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        Theme.configureTheme()
    }
    
    func startApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator?.start()
    }
}
