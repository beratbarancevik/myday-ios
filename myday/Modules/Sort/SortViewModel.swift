//
//  SortViewModel.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

class SortViewModel: BaseViewModel {
    // MARK: - Properties
    var sortOptions = SortOption.allCases
}

// MARK: - Sort Options
enum SortOption: CaseIterable {
    case alphabeticAsc
    case alphabeticDesc
    case creationDateAsc
    case creationDateDesc
    case progressRateAsc
    case progressRateDesc
    
    var title: String {
        switch self {
        case .alphabeticAsc:
            return "A to Z"
        case .alphabeticDesc:
            return "Z to A"
        case .creationDateAsc:
            return "First created first"
        case .creationDateDesc:
            return "First created last"
        case .progressRateAsc:
            return "Completed First"
        case .progressRateDesc:
            return "Completed Last"
        }
    }
}
