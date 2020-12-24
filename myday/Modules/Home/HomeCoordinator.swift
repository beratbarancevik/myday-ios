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
    
    private var calendarCoordinator: CalendarCoordinator?
    private var profileCoordinator: ProfileCoordinator?
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
        cancellables.insert(homeViewController.didTapCalendar.sink { [weak self] _ in
            guard let self = self else { return }
            self.calendarCoordinator = CalendarCoordinator(navigationController: self.navigationController)
            self.calendarCoordinator?.start()
        })
        
        cancellables.insert(homeViewController.didTapProfile.sink { [weak self] _ in
            guard let self = self else { return }
            self.profileCoordinator = ProfileCoordinator(navigationController: self.navigationController)
            self.profileCoordinator?.start()
        })
        
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
