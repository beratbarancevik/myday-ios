//
//  ExternalNavigationManager.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import SafariServices
import UIKit

class ExternalNavigationManager {
    // MARK: - External Navigation
    func openURL(_ url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func openURL(_ urlString: String) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - SFSafariViewController
    func openURL(_ url: URL, from viewController: BaseViewController?) {
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .tintColor
        safariViewController.preferredBarTintColor = .systemBackground
        safariViewController.dismissButtonStyle = .close
        viewController?.present(safariViewController, animated: true)
    }
    
    func openURL(_ urlString: String, from viewController: BaseViewController?) {
        guard let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .tintColor
        safariViewController.preferredBarTintColor = .systemBackground
        safariViewController.dismissButtonStyle = .close
        viewController?.present(safariViewController, animated: true)
    }
}
