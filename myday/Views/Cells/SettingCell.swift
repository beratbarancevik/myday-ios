//
//  SettingCell.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import UIKit

class SettingCell: BaseTableCell {
    // MARK: - Properties
    private let iconImageView = UIImageView().style(Theme.Image.primary)
    private let titleLabel = UILabel().style(Theme.Label.Regular.primary)
    
    var settingType: SettingType? {
        didSet {
            iconImageView.image = settingType?.icon.image
            titleLabel.text = settingType?.title
        }
    }
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraints()
    }
}

// MARK: - Setup
extension SettingCell: Setup {
    func addSubviews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    func addConstraints() {
        iconImageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().inset(16)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(iconImageView.snp.trailing).offset(16)
            maker.top.trailing.bottom.equalToSuperview().inset(16)
        }
    }
}
