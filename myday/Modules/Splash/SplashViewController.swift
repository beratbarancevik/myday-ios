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
        setUpUI()
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
    func setUpUI() {
        view.backgroundColor = .systemBlue
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        
    }
}
