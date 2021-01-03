//
//  SortOptionCell.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

import UIKit

class SortOptionCell: BaseTableCell {
    // MARK: - Properties
    private let titleLabel = UILabel().style(Theme.Label.Regular.primary)
    
    var sortOption: SortOption? {
        didSet {
            titleLabel.text = sortOption?.title
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
        addSubviews()
        addConstraints()
    }
}

// MARK: - Setup
extension SortOptionCell: Setup {
    func setUpUI() {
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    func addSubviews() {
        addSubview(titleLabel)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.centerY.equalToSuperview()
        }
    }
}
