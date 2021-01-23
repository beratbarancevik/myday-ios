//
//  BaseViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import SwiftMessages
import UIKit

@objc protocol Setup {
    @objc optional func setUpUI()
    @objc optional func addSubviews()
    @objc optional func addConstraints()
    @objc optional func addObservers()
}

class BaseViewController: UIViewController {
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
    
    var safeArea: UILayoutGuide {
        return view.safeAreaLayoutGuide
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.style(Theme.View.primary)
    }
    
    // MARK: - Alerts
    func showError(_ error: Error? = nil) {
        SwiftMessages.hideAll()
        let view = MessageView.viewFromNib(layout: .statusLine)
        view.configureTheme(.error)
        view.configureDropShadow()
        view.configureContent(body: (error?.localizedDescription ?? "default_error".localized))
        var config = SwiftMessages.Config()
        config.presentationStyle = .top
        config.presentationContext = .automatic
        config.duration = .seconds(seconds: 1.5)
        config.dimMode = .gray(interactive: true)
        config.interactiveHide = true
        config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: config, view: view)
    }
}
