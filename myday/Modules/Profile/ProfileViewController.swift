//
//  ProfileViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine
import UIKit

class ProfileViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ProfileViewModel
    
    private let settingsBarButtonItem = UIBarButtonItem(image: Images.settings.image, style: .plain, target: nil, action: nil)
    
    let didTapSettings = PassthroughSubject<Bool, Never>()
    
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
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
private extension ProfileViewController {
    @objc func settingsDidTap() {
        didTapSettings.send(true)
    }
}

// MARK: - Setup
extension ProfileViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Profile"
        
        settingsBarButtonItem.target = self
        settingsBarButtonItem.accessibilityLabel = "settings".localized
        navigationItem.rightBarButtonItem = settingsBarButtonItem
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        settingsBarButtonItem.action = #selector(settingsDidTap)
    }
}
