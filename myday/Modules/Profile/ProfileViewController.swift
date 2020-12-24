//
//  ProfileViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import UIKit

class ProfileViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ProfileViewModel
    
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
    
}

// MARK: - Setup
extension ProfileViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Profile"
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        
    }
}
