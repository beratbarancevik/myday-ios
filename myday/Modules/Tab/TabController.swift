//
//  TabController.swift
//  myday
//
//  Created by Berat Cevik on 1/11/21.
//

import UIKit

class TabController: UITabBarController {
    // MARK: - Properties
    private let viewModel: TabViewModel
    
    private var navigationControllers: [BaseNavigationController]
    
    // MARK: - Init
    init(viewModel: TabViewModel, navigationControllers: [BaseNavigationController]) {
        self.viewModel = viewModel
        self.navigationControllers = navigationControllers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = navigationControllers
        tabBar.style(Theme.TabBar.regular)
    }
}

// MARK: - Private Functions
private extension TabController {
    
}
