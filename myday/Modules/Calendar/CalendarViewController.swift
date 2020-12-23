//
//  CalendarViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import UIKit

class CalendarViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: CalendarViewModel
    
    // MARK: - Init
    init(viewModel: CalendarViewModel) {
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
private extension CalendarViewController {
    
}

// MARK: - Setup
extension CalendarViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Calendar"
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        
    }
}
