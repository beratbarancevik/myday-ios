//
//  AuthenticationCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine

class AuthenticationCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let authenticationViewController: AuthenticationViewController
    private let authenticationViewModel: AuthenticationViewModel
    
    private var settingsCoordinator: SettingsCoordinator?
    
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        authenticationViewModel = AuthenticationViewModel()
        authenticationViewController = AuthenticationViewController(viewModel: authenticationViewModel)
        observe()
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(authenticationViewController, animated: false)
    }
    
    func observe() {
        cancellables.insert(authenticationViewController.didTapSettingsSubject.sink { [weak self] _ in
            guard let self = self else { return }
            self.settingsCoordinator = SettingsCoordinator(navigationController: self.navigationController)
            self.settingsCoordinator?.start()
        })
    }
}
