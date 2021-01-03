//
//  GoalCell.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class GoalCell: BaseTableCell {
    // MARK: - Properties
    private let titleLabel = UILabel().style(Theme.Label.Regular.primary)
    private let targetLabel: UILabel = {
        $0.style(Theme.Label.Regular.primary)
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    
    var index: Int?
    var goal: Goal? {
        didSet {
            guard let goal = goal else { return }
            titleLabel.text = goal.title
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
extension GoalCell: Setup {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(targetLabel)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(16)
            maker.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
