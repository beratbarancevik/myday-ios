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
    private let homeViewModel: HomeViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        homeViewModel = HomeViewModel()
        homeViewController = HomeViewController(viewModel: homeViewModel)
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
