//
//  HomeCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine

class HomeCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let homeViewController: HomeViewController
    private let homeViewModel: HomeViewModel
    
    private var goalDetailCoordinator: GoalDetailCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        homeViewModel = HomeViewModel()
        homeViewController = HomeViewController(viewModel: homeViewModel)
        observe()
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(homeViewController, animated: true)
    }
    
    func observe() {
        cancellables.insert(homeViewController.didSelectGoal.sink { [weak self] goal in
            guard let self = self else { return }
            self.goalDetailCoordinator = GoalDetailCoordinator(navigationController: self.navigationController, goal: goal)
            self.goalDetailCoordinator?.start()
        })
        
        cancellables.insert(homeViewController.addGoal.sink { [weak self] _ in
            guard let self = self else { return }
            self.goalDetailCoordinator = GoalDetailCoordinator(navigationController: self.navigationController)
            self.goalDetailCoordinator?.start()
        })
    }
}
