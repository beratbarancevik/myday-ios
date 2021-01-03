//
//  ProfileViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine

class ProfileViewModel: BaseViewModel {
    // MARK: - Properties
    var user: User?
    
    let loadingSubject = PassthroughSubject<Bool, Never>()
    let userSubject = PassthroughSubject<User, Error>()
    
    // MARK: - Service Requests
    func getUser() {
        loadingSubject.send(true)
        UserServices.getUser(id: AuthenticationManager.shared.userId) { [weak self] result in
            self?.loadingSubject.send(false)
            switch result {
            case .success(let response):
                self?.user = response
                self?.userSubject.send(response)
            case .failure(let error):
                self?.userSubject.send(completion: Subscribers.Completion.failure(error))
            }
        }
    }
}
