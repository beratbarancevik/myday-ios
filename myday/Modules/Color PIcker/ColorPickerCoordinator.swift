//
//  ColorPickerCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

class ColorPickerCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let colorPickerViewController: ColorPickerViewController
    private let colorPickerViewModel: ColorPickerViewModel
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        colorPickerViewModel = ColorPickerViewModel()
        colorPickerViewController = ColorPickerViewController(viewModel: colorPickerViewModel)
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(colorPickerViewController, animated: true)
    }
}
