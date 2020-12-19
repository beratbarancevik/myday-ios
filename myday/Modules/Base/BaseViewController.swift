//
//  BaseViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import UIKit

@objc protocol Setup {
    @objc optional func addObservers()
}

class BaseViewController: UIViewController {
    // MARK: - Properties
    var cancellables = Set<AnyCancellable>()
}
