//
//  AppDelegate.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import FBSDKCoreKit
import Firebase
import SnapKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    private var applicationCoordinator: ApplicationCoordinator?
    
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp(application, with: launchOptions)
        startApp()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
}

// MARK: - Private Functions
private extension AppDelegate {
    func configureApp(_ application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        Theme.configureTheme()
    }
    
    func startApp() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        applicationCoordinator = ApplicationCoordinator(window: window)
        applicationCoordinator?.start()
    }
}
