//
//  TabController.swift
//  myday
//
//  Created by Berat Cevik on 1/11/21.
//

import UIKit

class TabController: UITabBarController {
    // MARK: - Properties
    private let viewModel: TabViewModel
    
    // MARK: - Init
    init(viewModel: TabViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
}

// MARK: - Setup
extension TabController: Setup {
    func setUpUI() {
        let calendar = generateNavigationController(viewController: CalendarViewController(viewModel: CalendarViewModel()), for: .calendar)
        let goals = generateNavigationController(viewController: GoalsViewController(viewModel: GoalsViewModel()), for: .goals)
        let account: BaseNavigationController
        if AuthenticationManager.shared.authState == .account {
            account = generateNavigationController(viewController: ProfileViewController(viewModel: ProfileViewModel()), for: .profile)
        } else {
            account = generateNavigationController(viewController: AuthenticationViewController(viewModel: AuthenticationViewModel()), for: .profile)
        }
        
        viewControllers = [
            calendar,
            goals,
            account
        ]
        
        tabBar.style(Theme.TabBar.regular)
    }
}

// MARK: - Private Functions
private extension TabController {
    func generateNavigationController(viewController: BaseViewController, for tabType: TabType) -> BaseNavigationController {
        let navigationController = BaseNavigationController(rootViewController: viewController)
        navigationController.tabBarItem.image = tabType.image.image
        return navigationController
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
