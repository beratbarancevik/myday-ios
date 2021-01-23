//
//  SplashController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import UIKit

class SplashController: BaseViewController {
    // MARK: - Properties
    private var viewModel = SplashViewModel()
    
    private let logoImageView: UIImageView = {
        $0.image = Image.logo.image
        $0.accessibilityLabel = "splash_logo_image_view".localized
        return $0
    }(UIImageView().style(Theme.Image.primary))
    
    private var cancellable: AnyCancellable?
    
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
        print("\(#function)")
        addSubviews()
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("\(#function)")
        // Authentication is configured here, so that splash controller appears on the screen
        addAuthenticationObserver()
        AuthenticationManager.shared.setUpAuthentication()
    }
}

// MARK: - Setup
extension SplashController: Setup {
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

// MARK: - Private Functions
private extension SplashController {
    func addAuthenticationObserver() {
        cancellable = AuthenticationManager.shared.authDidCompleteSubject.sink { [weak self] _ in
            #if DEBUG
            // makes sure that splash screen's UI gets tested
            if ProcessInfo.processInfo.environment["ShouldStopAtSplash"] == "YES" {
                print("UI tests are running for Splash screen")
                return
            }
            #endif
            self?.cancellable?.cancel()
            self?.showMain()
        }
    }

    func showMain() {
        UIApplication.shared.keyWindow?.rootViewController = TabController(viewModel: TabViewModel())
        UIApplication.shared.keyWindow?.makeKeyAndVisible()
    }
}
