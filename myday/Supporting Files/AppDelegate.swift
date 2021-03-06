//
//  AppDelegate.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import AlamofireNetworkActivityIndicator
import FBSDKCoreKit
import Firebase
import GoogleSignIn
import Kingfisher
import SnapKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Properties
    var window: UIWindow?
    
    static var isGoogleSignIn = false  // to detect if callback is for Google
    
    // MARK: - UIApplicationDelegate
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureApp(application, with: launchOptions)
        startApp()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AppEvents.activateApp()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        if AppDelegate.isGoogleSignIn {
            AppDelegate.isGoogleSignIn = false
            return GIDSignIn.sharedInstance()?.handle(url) ?? ApplicationDelegate.shared.application(app, open: url, options: options)
        }
        return ApplicationDelegate.shared.application(app, open: url, options: options)
    }
}

// MARK: - Private Functions
private extension AppDelegate {
    func configureApp(_ application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        // Firebase
        FirebaseConfiguration.shared.setLoggerLevel(.min)
        FirebaseApp.configure()
        
        // Google Sign In
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        
        // Facebook SDK
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // Theme
        Theme.configureTheme()
        
        // AlamofireNetworkActivityIndicator
        NetworkActivityIndicatorManager.shared.isEnabled = true
    }
    
    func startApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = SplashController(viewModel: SplashViewModel())
        window?.makeKeyAndVisible()
    }
}
