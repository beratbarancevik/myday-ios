//
//  ColorCell.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import UIKit

class ColorCell: BaseTableCell {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        $0.style(Theme.Label.Regular.primary)
        $0.text = "Color"
        return $0
    }(UILabel())
    private let colorView: UIView = {
        $0.layer.cornerRadius = 12
        $0.backgroundColor = .systemGreen
        return $0
    }(UIView())
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var colorName: String? {
        didSet {
            guard let colorName = colorName else { return }
            colorView.backgroundColor = GoalColor(colorName).color
        }
    }
    
    var goalColor: GoalColor? {
        didSet {
            colorView.backgroundColor = goalColor?.color
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
extension ColorCell: Setup {
    func setUpUI() {
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(colorView)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(16)
            maker.leading.equalToSuperview().inset(24)
        }
        
        colorView.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.trailing).offset(24)
            maker.trailing.equalToSuperview().inset(24)
            maker.centerY.equalToSuperview()
            maker.width.height.equalTo(24)
        }
    }
}
