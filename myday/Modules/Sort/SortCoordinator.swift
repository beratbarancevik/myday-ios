//
//  SortCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

class SortCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let sortViewController: SortViewController
    private let sortViewModel: SortViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        sortViewModel = SortViewModel()
        sortViewController = SortViewController(viewModel: sortViewModel)
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(sortViewController, animated: true)
    }
}
