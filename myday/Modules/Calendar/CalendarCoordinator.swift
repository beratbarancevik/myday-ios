//
//  CalendarCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

class CalendarCoordinator: BaseCoordinator {
    // MARK: - Properties
    private var presentingNavigationController: BaseNavigationController
    var navigationController: BaseNavigationController
    
    private let calendarViewController: CalendarViewController
    private let calendarViewModel: CalendarViewModel
    
    // MARK: - Init
    init(presentingNavigationController: BaseNavigationController, navigationController: BaseNavigationController) {
        self.presentingNavigationController = presentingNavigationController
        self.navigationController = navigationController
        calendarViewModel = CalendarViewModel()
        calendarViewController = CalendarViewController(viewModel: calendarViewModel)
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(calendarViewController, animated: false)
        presentingNavigationController.present(navigationController, animated: true)
    }
}
