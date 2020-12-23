//
//  GoalCell.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

protocol GoalCellDelegate: AnyObject {
    func targetDidTap(_ index: Int)
}

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
            if let target = goal.target {
                let achievedText = String(goal.achieved ?? 0)
                let targetText = String(target)
                targetLabel.text = "\(achievedText) / \(targetText)"
            }
        }
    }
    
    weak var delegate: GoalCellDelegate?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        addConstraints()
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        addSubviews()
        addConstraints()
        addObservers()
    }
}

// MARK: - Private Functions
private extension GoalCell {
    @objc func targetLabelDidTap() {
        guard let index = index else { return }
        delegate?.targetDidTap(index)
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
            maker.leading.equalToSuperview().inset(24)
        }
        
        targetLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.trailing).offset(24)
            maker.trailing.equalToSuperview().inset(24)
            maker.centerY.equalToSuperview()
        }
    }
    
    func addObservers() {
        targetLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(targetLabelDidTap)))
    }
}
