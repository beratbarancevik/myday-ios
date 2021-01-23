//
//  AuthenticationController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import ActiveLabel
import AuthenticationServices
import Combine
import UIKit

class AuthenticationController: BaseViewController {
    // MARK: - Properties
    private var viewModel: AuthenticationViewModel
    
    private let settingsBarButtonItem = UIBarButtonItem(image: Image.settings.image, style: .plain, target: nil, action: nil)
    private let infoLabel: UILabel = {
        $0.style(Theme.Label.Regular.primary)
        $0.text = "To access your data on all your devices please sign up."
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    private let buttonStackView: UIStackView = {
        $0.alignment = .fill
        $0.axis = .vertical
        $0.distribution = .fillEqually
        $0.spacing = 24
        return $0
    }(UIStackView())
    private let appleButton: UIButton = {
        $0.style(Theme.Button.primary)
        $0.setImage(Image.apple.image, for: .normal)
        $0.setTitle("Sign In with Apple", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        $0.tintColor = .systemBackground
        $0.backgroundColor = Color.apple.color
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.layer.cornerRadius = 24
        return $0
    }(UIButton(type: .system))
    private let facebookButton: UIButton = {
        $0.style(Theme.Button.primary)
        $0.setImage(Image.facebook.image, for: .normal)
        $0.setTitle("Log In with Facebook", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        $0.tintColor = .white
        $0.backgroundColor = Color.facebook.color
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 24
        return $0
    }(UIButton(type: .system))
    private let googleButton: UIButton = {
        $0.style(Theme.Button.primary)
        $0.setImage(Image.google.image, for: .normal)
        $0.setTitle("Continue with Google", for: .normal)
        $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        $0.tintColor = .white
        $0.backgroundColor = Color.google.color
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 24
        return $0
    }(UIButton(type: .system))
    private let activeLabel: ActiveLabel = {
        $0.style(Theme.Label.Tiny.primary)
        $0.text = "By signing up, you agree to the Terms & Conditions and the Privacy Policy."
        $0.numberOfLines = 0
        $0.lineSpacing = 5
        $0.textAlignment = .center
        return $0
    }(ActiveLabel())
    
    private let appleAuthManager = AppleAuthManager()
    private let facebookAuthManager = FacebookAuthManager()
    private let googleAuthManager = GoogleAuthManager()
    
    let didTapSettingsSubject = PassthroughSubject<Bool, Never>()
    let didTapTermsSubject = PassthroughSubject<Bool, Never>()
    let didTapPrivacySubject = PassthroughSubject<Bool, Never>()
    
    // MARK: - Init
    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addSubviews()
        addConstraints()
        addObservers()
    }
}

// MARK: - Private Functions
private extension AuthenticationController {
    @objc func settingsDidTap() {
        didTapSettingsSubject.send(true)
    }
    
    @objc func appleDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        appleAuthManager.delegate = self
        appleAuthManager.handleAppleAuth()
    }
    
    @objc func facebookDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        facebookAuthManager.delegate = self
        facebookAuthManager.handleFacebookAuth(from: self)
    }
    
    @objc func googleDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        googleAuthManager.delegate = self
        googleAuthManager.handleGoogleAuth(from: self)
    }
    
    @objc func termsDidTap() {
        didTapTermsSubject.send(true)
    }
    
    @objc func privacyDidTap() {
        didTapPrivacySubject.send(true)
    }
}

// MARK: - Setup
extension AuthenticationController: Setup {
    func setUpUI() {
        navigationItem.title = "Register / Login"
        
        settingsBarButtonItem.target = self
        settingsBarButtonItem.accessibilityLabel = "settings".localized
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        
        activeLabel.customize { label in
            let terms = ActiveType.custom(pattern: "\\sTerms & Conditions\\b")
            label.customColor[terms] = UIColor.tintColor
            
            let privacy = ActiveType.custom(pattern: "\\sPrivacy Policy\\b")
            label.customColor[privacy] = UIColor.tintColor
            
            label.enabledTypes = [terms, privacy]
            
            label.handleCustomTap(for: terms) { [weak self] _ in
                self?.didTapTermsSubject.send(true)
            }
            
            label.handleCustomTap(for: privacy) { [weak self] _ in
                self?.didTapPrivacySubject.send(true)
            }
        }
    }
    
    func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(appleButton)
        buttonStackView.addArrangedSubview(facebookButton)
        buttonStackView.addArrangedSubview(googleButton)
        view.addSubview(activeLabel)
    }
    
    func addConstraints() {
        infoLabel.snp.makeConstraints { maker in
            maker.top.equalTo(safeArea).inset(32)
            maker.leading.trailing.equalTo(safeArea).inset(32)
        }
        
        buttonStackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(safeArea).inset(32)
            maker.centerY.equalTo(safeArea)
        }
        
        buttonStackView.arrangedSubviews.forEach {
            $0.snp.makeConstraints { maker in
                maker.height.equalTo(48)
            }
        }
        
        activeLabel.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview().inset(16)
        }
    }
    
    func addObservers() {
        settingsBarButtonItem.action = #selector(settingsDidTap)
        appleButton.addTarget(self, action: #selector(appleDidTap), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookDidTap), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleDidTap), for: .touchUpInside)
    }
}

// MARK: - AppleAuthManagerDelegate
extension AuthenticationController: AppleAuthManagerDelegate {
    func appleSignInDidCancel() {}
    
    func appleSignInDidSucceed() {
        
    }
    
    func appleSignInDidFail(with error: Error) {
        showError(error)
    }
}

// MARK: - FacebookAuthManagerDelegate
extension AuthenticationController: FacebookAuthManagerDelegate {
    func facebookSignInDidCancel() {}
    
    func facebookSignInDidSucceed() {
        
    }
    
    func facebookSignInDidFail(with error: Error) {
        showError(error)
    }
}

// MARK: - GoogleAuthManagerDelegate
extension AuthenticationController: GoogleAuthManagerDelegate {
    func googleSignInDidCancel() {}
    
    func googleSignInDidSucceed() {
        
    }
    
    func googleSignInDidFail(with error: Error) {
        showError(error)
    }
}
