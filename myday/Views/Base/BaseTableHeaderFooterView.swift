//
//  BaseTableHeaderFooterView.swift
//  myday
//
//  Created by Berat Cevik on 12/25/20.
//

import UIKit

class BaseTableHeaderFooterView: UITableViewHeaderFooterView {
    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.style(Theme.View.primary)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.style(Theme.View.primary)
    }
}
