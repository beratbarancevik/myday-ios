//
//  BaseView.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class BaseView: UIView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        style(Theme.View.primary)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        style(Theme.View.primary)
    }
}
