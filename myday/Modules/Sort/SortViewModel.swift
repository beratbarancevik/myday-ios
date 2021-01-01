//
//  SortViewModel.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

class SortViewModel: BaseViewModel {
    // MARK: - Properties
    var sortOptions = SortOptions.allCases
}

// MARK: - Sort Options
enum SortOptions: CaseIterable {
    case alphabeticAsc
    case alphabeticDesc
    case creationDateAsc
    case creationDateDesc
    case completionAsc
    case completionDesc
}
