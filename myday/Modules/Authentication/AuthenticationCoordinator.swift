//
//  AuthenticationCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine

class AuthenticationCoordinator: BaseCoordinator {
    // MARK: - Properties
    private var presentingNavigationController: BaseNavigationController
    var navigationController: BaseNavigationController
    
    private let authenticationViewController: AuthenticationViewController
    private let authenticationViewModel: AuthenticationViewModel
    
    private var settingsCoordinator: SettingsCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        authenticationViewModel = AuthenticationViewModel()
        authenticationViewController = AuthenticationViewController(viewModel: authenticationViewModel)
        observe()
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(authenticationViewController, animated: false)
        presentingNavigationController.present(navigationController, animated: true)
    }
    
    func observe() {
        cancellables.insert(authenticationViewController.didTapSettings.sink { [weak self] _ in
            guard let self = self else { return }
            self.settingsCoordinator = SettingsCoordinator(navigationController: self.navigationController)
            self.settingsCoordinator?.start()
        })
    }
}
