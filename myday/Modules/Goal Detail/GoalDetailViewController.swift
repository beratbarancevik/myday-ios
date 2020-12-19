//
//  GoalDetailViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class GoalDetailViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: GoalDetailViewModel
    
    // MARK: - Init
    init(viewModel: GoalDetailViewModel) {
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
private extension GoalDetailViewController {
    
}

// MARK: - Setup
extension GoalDetailViewController: Setup {
    func setUpUI() {
        
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        
    }
}
