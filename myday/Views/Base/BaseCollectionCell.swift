//
//  BaseCollectionCell.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import UIKit

class BaseCollectionCell: UICollectionViewCell {
    // MARK: - Properties
    static var identifier: String {
        return String(describing: self)
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.style(Theme.View.primary)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.style(Theme.View.primary)
    }
}
