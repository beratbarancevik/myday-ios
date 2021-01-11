//
//  HomeCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import Foundation

class HomeCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let homeViewController: HomeViewController
    private let homeViewModel: HomeViewModel
    
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
        homeViewModel = HomeViewModel()
        sortViewModel = SortViewModel()
        sortViewController = SortViewController(viewModel: sortViewModel)
        homeViewController = HomeViewController(viewModel: homeViewModel, sortViewController: sortViewController)
        observe()
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func observe() {
        cancellables.insert(homeViewController.didTapSortSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.sortCoordinator = SortCoordinator(navigationController: self.navigationController, viewController: self.sortViewController, viewModel: self.sortViewModel)
            self.sortCoordinator?.start()
        })
        
        cancellables.insert(homeViewController.didSelectGoalSubject.sink { [weak self] goal in
            guard let self = self else { return }
            let goalDetailNavigationController = BaseNavigationController()
            self.goalDetailCoordinator = GoalDetailCoordinator(presentingNavigationController: self.navigationController, navigationController: goalDetailNavigationController, goal: goal)
            self.goalDetailCoordinator?.start()
        })
        
        cancellables.insert(homeViewController.didTapAddGoalSubject.sink { [weak self] _ in
            guard let self = self else { return }
            let goalDetailNavigationController = BaseNavigationController()
            self.goalDetailCoordinator = GoalDetailCoordinator(presentingNavigationController: self.navigationController, navigationController: goalDetailNavigationController)
            self.goalDetailCoordinator?.start()
        })
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSaveGoal), name: .didSaveGoal, object: nil)
    }
}

// MARK: - Private Functions
private extension HomeCoordinator {
    @objc func didSaveGoal() {
        goalDetailCoordinator?.navigationController.dismiss(animated: true)
        goalDetailCoordinator = nil
    }
}
