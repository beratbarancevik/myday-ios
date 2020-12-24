//
//  ProfileCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine

class ProfileCoordinator: BaseCoordinator {
    // MARK: - Properties
    private var presentingNavigationController: BaseNavigationController
    var navigationController: BaseNavigationController
    
    private let profileViewController: ProfileViewController
    private let profileViewModel: ProfileViewModel
    
    private var settingsCoordinator: SettingsCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        profileViewModel = ProfileViewModel()
        profileViewController = ProfileViewController(viewModel: profileViewModel)
        observe()
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(profileViewController, animated: false)
        presentingNavigationController.present(navigationController, animated: true)
    }
    
    func observe() {
        cancellables.insert(profileViewController.didTapSettings.sink { [weak self] _ in
            guard let self = self else { return }
            self.settingsCoordinator = SettingsCoordinator(navigationController: self.navigationController)
            self.settingsCoordinator?.start()
        })
    }
}
