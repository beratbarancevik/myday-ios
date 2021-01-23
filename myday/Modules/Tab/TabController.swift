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
        registerAuthChanges()
    }
}

// MARK: - Setup
extension TabController: Setup {
    func setUpUI() {
        let calendar = generateNavigationController(viewController: CalendarViewController(viewModel: CalendarViewModel()), for: .calendar)
        let goals = generateNavigationController(viewController: GoalsViewController(viewModel: GoalsViewModel()), for: .goals)
        let account = generateAccountNavigationController(for: AuthenticationManager.shared.authState)
        
        viewControllers = [
            calendar,
            goals,
            account
        ]
        
        selectedIndex = 1
        
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
    
    func generateAccountNavigationController(for authState: AuthState) -> BaseNavigationController {
        if authState == .anonymous {
            return generateNavigationController(viewController: AuthenticationController(viewModel: AuthenticationViewModel()), for: .profile)
        } else {
            return generateNavigationController(viewController: ProfileController(viewModel: ProfileViewModel()), for: .profile)
        }
    }
    
    func registerAuthChanges() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateAccountTab), name: .authStateDidChange, object: nil)
    }
    
    @objc func updateAccountTab(for authState: AuthState) {
        let account = generateAccountNavigationController(for: authState)
        viewControllers![viewControllers!.count - 1] = account
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
