//
//  TabCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 1/11/21.
//

import Combine
import UIKit

class TabCoordinator: BaseCoordinator {
    // MARK: - Properties
    private let window: UIWindow
    
    private var tabController: TabController?
    private let tabViewModel: TabViewModel
    
    private var navigationControllers = [BaseNavigationController]()
    
    private var goalsCoordinator: GoalsCoordinator?
    private var calendarCoordinator: CalendarCoordinator?
    private var profileCoordinator: ProfileCoordinator?
    private var authenticationCoordinator: AuthenticationCoordinator?
    
    private var cancellable: AnyCancellable?
    
    // MARK: - Init
    init(window: UIWindow) {
        self.window = window
        tabViewModel = TabViewModel()
    }
    
    // MARK: - Coordinator
    func start() {
        let goalsNavigationController = generateNavigationController(for: .goals)
        let calendarNavigationController = generateNavigationController(for: .calendar)
        let profileNavigationController = generateNavigationController(for: .profile)
        
        goalsCoordinator = GoalsCoordinator(navigationController: goalsNavigationController)
        calendarCoordinator = CalendarCoordinator(navigationController: calendarNavigationController)
        if AuthenticationManager.shared.authState == .account {
            profileCoordinator = ProfileCoordinator(navigationController: profileNavigationController)
        } else {
            authenticationCoordinator = AuthenticationCoordinator(navigationController: profileNavigationController)
        }
        
        navigationControllers = [
            calendarNavigationController,
            goalsNavigationController,
            profileNavigationController
        ]
        tabController = TabController(viewModel: tabViewModel, navigationControllers: navigationControllers)
        tabController?.selectedIndex = 1
        window.rootViewController = tabController
        startCoordinators()
    }
}

// MARK: - Private Extension
private extension TabCoordinator {
    func generateNavigationController(for tabType: TabType) -> BaseNavigationController {
        let navigationController = BaseNavigationController()
        navigationController.tabBarItem.image = tabType.image.image
        return navigationController
    }
    
    func startCoordinators() {
        goalsCoordinator?.start()
        calendarCoordinator?.start()
        if AuthenticationManager.shared.authState == .account {
            profileCoordinator?.start()
        } else {
            authenticationCoordinator?.start()
        }
    }
    
    func addAuthenticationObserver() {
        cancellable = AuthenticationManager.shared.authStateDidChangeSubject.sink { [weak self] authState in
            guard let navigationController = self?.generateNavigationController(for: .profile) else { return }
            
            if authState == .account {
                self?.profileCoordinator = ProfileCoordinator(navigationController: navigationController)
                self?.navigationControllers[2] = navigationController
                self?.profileCoordinator?.start()
            } else if authState == .anonymous {
                self?.authenticationCoordinator = AuthenticationCoordinator(navigationController: navigationController)
                self?.navigationControllers[2] = navigationController
                self?.authenticationCoordinator?.start()
            }
        }
    }
}

// MARK: - TabType
private enum TabType: String {
    case goals
    case calendar
    case profile
    
    var image: Image {
        switch self {
        case .goals:
            return Image.goals
        case .calendar:
            return Image.calendar
        case .profile:
            return Image.profile
        }
    }
}
