//
//  GoalsCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import Foundation

class GoalsCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let goalsViewController: GoalsViewController
    private let goalsViewModel: GoalsViewModel
    
    private let sortViewController: SortViewController
    private let sortViewModel: SortViewModel
    
    private var sortCoordinator: SortCoordinator?
    private var authenticationCoordinator: AuthenticationCoordinator?
    private var goalDetailCoordinator: GoalDetailCoordinator?
    
    var profileNavigationController = BaseNavigationController()
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        goalsViewModel = GoalsViewModel()
        sortViewModel = SortViewModel()
        sortViewController = SortViewController(viewModel: sortViewModel)
        goalsViewController = GoalsViewController(viewModel: goalsViewModel)
        observe()
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(goalsViewController, animated: true)
    }
    
    func observe() {
        cancellables.insert(goalsViewController.didTapSortSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.sortCoordinator = SortCoordinator(navigationController: self.navigationController, viewController: self.sortViewController, viewModel: self.sortViewModel)
            self.sortCoordinator?.start()
        })
        
        cancellables.insert(goalsViewController.didSelectGoalSubject.sink { [weak self] goal in
            guard let self = self else { return }
            let goalDetailNavigationController = BaseNavigationController()
            self.goalDetailCoordinator = GoalDetailCoordinator(presentingNavigationController: self.navigationController, navigationController: goalDetailNavigationController, goal: goal)
            self.goalDetailCoordinator?.start()
        })
        
        cancellables.insert(goalsViewController.didTapAddGoalSubject.sink { [weak self] _ in
            guard let self = self else { return }
            let goalDetailNavigationController = BaseNavigationController()
            self.goalDetailCoordinator = GoalDetailCoordinator(presentingNavigationController: self.navigationController, navigationController: goalDetailNavigationController)
            self.goalDetailCoordinator?.start()
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSaveGoal), name: .didSaveGoal, object: nil)
    }
}

// MARK: - Private Functions
private extension GoalsCoordinator {
    @objc func didSaveGoal() {
        goalDetailCoordinator?.navigationController.dismiss(animated: true)
        goalDetailCoordinator = nil
    }
}
