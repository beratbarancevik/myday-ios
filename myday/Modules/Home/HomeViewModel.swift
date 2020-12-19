//
//  HomeViewModel.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

class HomeViewModel: BaseViewModel {
    // MARK: - Service Requests
    func getGoals() {
        GoalServices.getGoals { result in
            switch result {
            case .success(let response):
                print(response.data.count)
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
            }
        }
    }
}
