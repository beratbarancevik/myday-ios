//
//  CalendarCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

class CalendarCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let calendarViewController: CalendarViewController
    private let calendarViewModel: CalendarViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        calendarViewModel = CalendarViewModel()
        calendarViewController = CalendarViewController(viewModel: calendarViewModel)
    }
    
    // MARK: - Functions
    func start() {
        navigationController.present(BaseNavigationController(rootViewController: calendarViewController), animated: true)
    }
}
