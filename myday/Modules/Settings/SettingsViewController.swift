//
//  SettingsViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class SettingsViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: SettingsViewModel
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
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
private extension SettingsViewController {
    
}

// MARK: - Setup
extension SettingsViewController: Setup {
    func setUpUI() {
        
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        
    }
}
