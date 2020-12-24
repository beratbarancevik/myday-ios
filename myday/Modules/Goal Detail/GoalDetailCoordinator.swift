//
//  GoalDetailCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class GoalDetailCoordinator: BaseCoordinator {
    // MARK: - Properties
    private var presentingNavigationController: BaseNavigationController
    var navigationController: BaseNavigationController
    
    private let goalDetailViewController: GoalDetailViewController
    private let goalDetailViewModel: GoalDetailViewModel
    
    // MARK: - Init
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        goalDetailViewModel = GoalDetailViewModel()
        goalDetailViewController = GoalDetailViewController(viewModel: goalDetailViewModel)
    }
    
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController, goal: Goal) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        goalDetailViewModel = GoalDetailViewModel(goal: goal)
        goalDetailViewController = GoalDetailViewController(viewModel: goalDetailViewModel)
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(goalDetailViewController, animated: false)
        presentingNavigationController.present(navigationController, animated: true)
    }
}
