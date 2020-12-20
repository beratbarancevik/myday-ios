//
//  SplashViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class SplashViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: SplashViewModel
    
    private let logoImageView: UIImageView = {
        $0.image = Images.logo.image
        $0.accessibilityLabel = "splash_logo_image_view".localized
        return $0
    }(UIImageView().style(Theme.Image.primary))
    
    // MARK: - Init
    init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /// Authentication is configured here, so that splash controller appears on the screen
        AuthenticationManager.shared.setUpAuthentication()
    }
}

// MARK: - Setup
extension SplashViewController: Setup {
    func addSubviews() {
        view.addSubview(logoImageView)
    }
    
    func addConstraints() {
        logoImageView.snp.makeConstraints { maker in
            maker.center.equalTo(safeArea)
            maker.width.height.equalTo(128)
        }
    }
}
