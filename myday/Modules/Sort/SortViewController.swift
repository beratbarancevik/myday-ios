//
//  SortViewController.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

import UIKit

class SortViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: SortViewModel
    
    // MARK: - Init
    init(viewModel: SortViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
