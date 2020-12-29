//
//  AuthenticationViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import AuthenticationServices
import Combine
import UIKit

class AuthenticationViewController: BaseViewController {
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
    private let legalLabel: UILabel = {
        $0.style(Theme.Label.Tiny.primary)
        $0.text = "By signing up, you agree to the Terms & Conditions and the Privacy Policy."
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel())
    private let legalStackView: UIStackView = {
        $0.alignment = .center
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 8
        return $0
    }(UIStackView())
    private let termsButton: UIButton = {
        $0.setTitle("Terms & Conditions", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        $0.backgroundColor = .clear
        $0.setTitleColor(.label, for: .normal)
        return $0
    }(UIButton(type: .system))
    private let privacyButton: UIButton = {
        $0.setTitle("Privacy Policy", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .medium)
        $0.backgroundColor = .clear
        $0.setTitleColor(.label, for: .normal)
        return $0
    }(UIButton(type: .system))
    
    let didTapSettingsSubject = PassthroughSubject<Bool, Never>()
    let didTapGoogleSubject = PassthroughSubject<Bool, Never>()
    let didTapFacebookSubject = PassthroughSubject<Bool, Never>()
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
private extension AuthenticationViewController {
    @objc func settingsDidTap() {
        didTapSettingsSubject.send(true)
    }
    
    @objc func appleDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        let appleAuthManager = AppleAuthManager()
        appleAuthManager.delegate = self
        appleAuthManager.handleAppleAuth()
    }
    
    @objc func facebookDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        didTapFacebookSubject.send(true)
    }
    
    @objc func googleDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        didTapGoogleSubject.send(true)
    }
    
    @objc func termsDidTap() {
        didTapTermsSubject.send(true)
    }
    
    @objc func privacyDidTap() {
        didTapPrivacySubject.send(true)
    }
}

// MARK: - Setup
extension AuthenticationViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Register / Login"
        
        settingsBarButtonItem.target = self
        settingsBarButtonItem.accessibilityLabel = "settings".localized
        navigationItem.rightBarButtonItem = settingsBarButtonItem
    }
    
    func addSubviews() {
        view.addSubview(infoLabel)
        view.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(appleButton)
        buttonStackView.addArrangedSubview(facebookButton)
        buttonStackView.addArrangedSubview(googleButton)
        view.addSubview(legalLabel)
        view.addSubview(legalStackView)
        legalStackView.addArrangedSubview(termsButton)
        legalStackView.addArrangedSubview(privacyButton)
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
        
        legalLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(8)
        }
        
        legalStackView.snp.makeConstraints { maker in
            maker.top.equalTo(legalLabel.snp.bottom).offset(8)
            maker.leading.trailing.equalToSuperview().inset(32)
            maker.bottom.equalTo(safeArea).inset(8)
        }
        
        termsButton.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
        }
        
        privacyButton.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview()
        }
    }
    
    func addObservers() {
        settingsBarButtonItem.action = #selector(settingsDidTap)
        appleButton.addTarget(self, action: #selector(appleDidTap), for: .touchUpInside)
        facebookButton.addTarget(self, action: #selector(facebookDidTap), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleDidTap), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(termsDidTap), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(privacyDidTap), for: .touchUpInside)
    }
}

// MARK: - AppleAuthManagerDelegate
extension AuthenticationViewController: AppleAuthManagerDelegate {
    func appleSignInDidSucceed() {
        
    }
    
    func appleSignInDidFail(with error: Error) {
        showError(error)
    }
}
