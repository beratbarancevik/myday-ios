//
//  SettingsCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class SettingsCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    // MARK: - Init
    init(presenter: BaseNavigationController) {
        navigationController = presenter
    }
    
    // MARK: - Functions
    func start() {}
}
