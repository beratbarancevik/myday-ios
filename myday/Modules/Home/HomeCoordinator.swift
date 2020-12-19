//
//  HomeCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class HomeCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let presenter: BaseNavigationController
    private let homeViewController: HomeViewController
    
    // MARK: - Init
    init(presenter: BaseNavigationController) {
        self.presenter = presenter
        homeViewController = HomeViewController(viewModel: HomeViewModel())
    }
    
    // MARK: - Coordinator
    func start() {
        presenter.pushViewController(homeViewController, animated: true)
    }
}
