//
//  SettingsCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class SettingsCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let settingsViewController: SettingsViewController
    private let settingsViewModel: SettingsViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        settingsViewModel = SettingsViewModel()
        settingsViewController = SettingsViewController(viewModel: settingsViewModel)
    }
    
    // MARK: - Functions
    func start() {}
}
