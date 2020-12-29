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
    private var authenticationCoordinator: AuthenticationCoordinator?
    private var goalDetailCoordinator: GoalDetailCoordinator?
    
    var profileNavigationController = BaseNavigationController()
    
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
        cancellables.insert(homeViewController.didTapCalendarSubject.sink { [weak self] _ in
            guard let self = self else { return }
            let calendarNavigationController = BaseNavigationController()
            self.calendarCoordinator = CalendarCoordinator(presentingNavigationController: self.navigationController, navigationController: calendarNavigationController)
            self.calendarCoordinator?.start()
        })
        
        cancellables.insert(homeViewController.didTapProfileSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.profileNavigationController = BaseNavigationController()
            if AuthenticationManager.shared.authState == .account {
                self.profileCoordinator = ProfileCoordinator(presentingNavigationController: self.navigationController, navigationController: self.profileNavigationController)
                self.profileCoordinator?.start()
            } else {
                self.authenticationCoordinator = AuthenticationCoordinator(presentingNavigationController: self.navigationController, navigationController: self.profileNavigationController)
                self.authenticationCoordinator?.start()
            }
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
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: .didSignIn, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didLogOut), name: .didLogOut, object: nil)
    }
}

// MARK: - Private Functions
private extension HomeCoordinator {
    @objc func didSaveGoal() {
        goalDetailCoordinator?.navigationController.dismiss(animated: true)
        goalDetailCoordinator = nil
    }
    
    @objc func didSignIn() {
        profileCoordinator = ProfileCoordinator(presentingNavigationController: navigationController, navigationController: profileNavigationController)
        profileCoordinator?.replace()
    }
    
    @objc func didLogOut() {
        profileNavigationController.dismiss(animated: true)
    }
}
