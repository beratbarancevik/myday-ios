//
//  HomeViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class HomeViewController: BaseViewController {
    private var viewModel: HomeViewModel
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        addObservers()
        
        viewModel.getGoals()
    }
}

// MARK: - Setup
extension HomeViewController: Setup {
    func addObservers() {
        cancellables.insert(viewModel.loadingSubject.sink { [weak self] value in
            print(value)
        })
    }
}
