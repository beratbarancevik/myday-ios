//
//  HomeCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class HomeCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let homeViewController: HomeViewController
    
    // MARK: - Init
    init(presenter: BaseNavigationController) {
        navigationController = presenter
        homeViewController = HomeViewController(viewModel: HomeViewModel())
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
