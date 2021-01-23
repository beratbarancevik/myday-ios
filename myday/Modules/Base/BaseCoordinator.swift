//
//  BaseCoordinator.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Foundation

@objc protocol BaseCoordinator {
    @objc optional var navigationController: BaseNavigationController { get }
    func start()
}
