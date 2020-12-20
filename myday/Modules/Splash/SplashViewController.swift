//
//  SplashViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
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
    
    deinit {
        print("SplashViewController deinited")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        addConstraints()
        addObservers()
    }
}

// MARK: - Private Functions
private extension SplashViewController {
    
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
    
    func addObservers() {
        cancellables.insert(AuthenticationManager.shared.authDidCompleteSubject.sink(receiveValue: { [weak self] _ in
            
        }))
    }
}
