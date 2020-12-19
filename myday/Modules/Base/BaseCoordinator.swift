//
//  BaseCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

protocol BaseCoordinator {
    var navigationController: BaseNavigationController { get }
    func start()
}
