//
//  HomeViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import Foundation

class HomeViewModel: BaseViewModel {
    // MARK: - Properties
    var loadingSubject = PassthroughSubject<Bool, Never>()
    
    // MARK: - Service Requests
    func getGoals() {
        loadingSubject.send(true)
        GoalServices.getGoals { [weak self] result in
            self?.loadingSubject.send(false)
            switch result {
            case .success(let response):
                NotificationCenter.default.post(name: .requestDidSucceed, object: response)
            case .failure(let error):
                NotificationCenter.default.post(name: .requestDidFail, object: error)
            }
        }
    }
}
