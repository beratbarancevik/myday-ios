//
//  SortCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

class SortCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    let sortViewController: SortViewController
    private let sortViewModel: SortViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController, viewController: SortViewController, viewModel: SortViewModel) {
        self.navigationController = navigationController
        sortViewModel = viewModel
        sortViewController = viewController
    }
    
    // MARK: - Functions
    func start() {
        navigationController.present(sortViewController, animated: true)
    }
}
