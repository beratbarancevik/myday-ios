//
//  ColorPickerViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import UIKit

class ColorPickerViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ColorPickerViewModel
    
    // MARK: - Init
    init(viewModel: ColorPickerViewModel) {
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
private extension ColorPickerViewController {
    
}

// MARK: - Setup
extension ColorPickerViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Color"
    }
    
    func addSubviews() {
        
    }
    
    func addConstraints() {
        
    }
    
    func addObservers() {
        
    }
}
