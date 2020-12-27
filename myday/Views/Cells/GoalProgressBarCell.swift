//
//  GoalProgressBarCell.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import UIKit

protocol GoalProgressBarCellDelegate: AnyObject {
    func targetDidTap(_ index: Int)
}

class GoalProgressBarCell: BaseTableCell {
    // MARK: - Properties
    private let titleLabel = UILabel().style(Theme.Label.Regular.primary)
    private let targetLabel: UILabel = {
        $0.style(Theme.Label.Regular.primary)
        $0.isUserInteractionEnabled = true
        return $0
    }(UILabel())
    private let progressBar = HorizontalProgressBar(frame: .zero)
    
    var index: Int?
    var goal: Goal? {
        didSet {
            guard let goal = goal else { return }
            titleLabel.text = goal.title
            if let target = goal.target {
                let achieved = goal.achieved ?? 0
                let achievedText = String(achieved)
                let targetText = String(target)
                targetLabel.text = "\(achievedText) / \(targetText)"
                
                let achievedFloat = Float(achieved)
                let targetFloat = Float(target)
                let progress = achievedFloat / targetFloat
                progressBar.progress = progress
                progressBar.progressBarTintColor = (GoalColor(goal.color)).color
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
private extension GoalProgressBarCell {
    @objc func targetLabelDidTap() {
        guard let index = index else { return }
        delegate?.targetDidTap(index)
    }
}

// MARK: - Setup
extension GoalProgressBarCell: Setup {
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(targetLabel)
        addSubview(progressBar)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(16)
            maker.leading.equalToSuperview().inset(24)
        }
        
        targetLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(titleLabel.snp.trailing).offset(24)
            maker.trailing.equalToSuperview().inset(24)
            maker.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        progressBar.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(24)
            maker.leading.equalTo(titleLabel.snp.leading)
            maker.trailing.equalTo(targetLabel.snp.trailing)
            maker.bottom.equalToSuperview().inset(16)
            maker.height.equalTo(12)
        }
    }
    
    func addObservers() {
        targetLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(targetLabelDidTap)))
    }
}
