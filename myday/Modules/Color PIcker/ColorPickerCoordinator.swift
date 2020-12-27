//
//  ColorPickerCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine

protocol ColorPickerCoordinatorDelegate: AnyObject {
    func didPickColor(_ color: GoalColor)
}

class ColorPickerCoordinator: BaseCoordinator {
    // MARK: - Properties
    var navigationController: BaseNavigationController
    
    private let colorPickerViewController: ColorPickerViewController
    private let colorPickerViewModel: ColorPickerViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    weak var delegate: ColorPickerCoordinatorDelegate?
    
    // MARK: - Init
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        colorPickerViewModel = ColorPickerViewModel()
        colorPickerViewController = ColorPickerViewController(viewModel: colorPickerViewModel)
        observe()
    }
    
    // MARK: - Functions
    func start() {
        navigationController.pushViewController(colorPickerViewController, animated: true)
    }
    
    func observe() {
        cancellables.insert(colorPickerViewController.didPickColorSubject.sink { [weak self] color in
            self?.delegate?.didPickColor(color)
            self?.navigationController.popToRootViewController(animated: true)
        })
    }
}
