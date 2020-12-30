//
//  BaseCollectionReusableView.swift
//  myday
//
//  Created by Berat Cevik on 12/30/20.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView {
    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.style(Theme.View.primary)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.style(Theme.View.primary)
    }
}
