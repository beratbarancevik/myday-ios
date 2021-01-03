//
//  GoalDetailCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine

class GoalDetailCoordinator: BaseCoordinator {
    // MARK: - Properties
    private var presentingNavigationController: BaseNavigationController
    var navigationController: BaseNavigationController
    
    private let goalDetailViewController: GoalDetailViewController
    private let goalDetailViewModel: GoalDetailViewModel
    
    private var colorPickerCoordinator: ColorPickerCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        goalDetailViewModel = GoalDetailViewModel()
        goalDetailViewController = GoalDetailViewController(viewModel: goalDetailViewModel)
        observe()
    }
    
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController, goal: Goal) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        goalDetailViewModel = GoalDetailViewModel(goal: goal)
        goalDetailViewController = GoalDetailViewController(viewModel: goalDetailViewModel)
        observe()
    }
    
    // MARK: - Coordinator
    func start() {
        navigationController.pushViewController(goalDetailViewController, animated: false)
        presentingNavigationController.present(navigationController, animated: true)
    }
    
    func observe() {
        cancellables.insert(goalDetailViewController.didTapColorSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.colorPickerCoordinator = ColorPickerCoordinator(navigationController: self.navigationController)
            self.colorPickerCoordinator?.delegate = self
            self.colorPickerCoordinator?.start()
        })
    }
}

// MARK: - ColorPickerCoordinatorDelegate
extension GoalDetailCoordinator: ColorPickerCoordinatorDelegate {
    func didPickColor(_ color: GoalColor) {
        goalDetailViewController.didPickColor(color)
    }
}
