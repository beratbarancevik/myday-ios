//
//  GoalDetailCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GoalDetailCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let goalDetailViewController: GoalDetailViewController
    private let goalDetailViewModel: GoalDetailViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        goalDetailViewModel = GoalDetailViewModel()
        goalDetailViewController = GoalDetailViewController(viewModel: goalDetailViewModel)
    }
    
    init(navigationController: BaseNavigationController, goal: Goal) {
        self.navigationController = navigationController
        goalDetailViewModel = GoalDetailViewModel(goal: goal)
        goalDetailViewController = GoalDetailViewController(viewModel: goalDetailViewModel)
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.present(goalDetailViewController, animated: true)
    }
}
