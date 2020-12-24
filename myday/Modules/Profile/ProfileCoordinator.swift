//
//  ProfileCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

class ProfileCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let profileViewController: ProfileViewController
    private let profileViewModel: ProfileViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        profileViewModel = ProfileViewModel()
        profileViewController = ProfileViewController(viewModel: profileViewModel)
    }
    
    // MARK: - Functions
    func start() {
        navigationController.present(BaseNavigationController(rootViewController: profileViewController), animated: true)
    }
}
