//
//  DayCell.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import UIKit

class DayCell: BaseCollectionCell {
    // MARK: - Properties
    private let containerView = UIView().style(Theme.View.primary)
    private let dayLabelCircleView: UIView = {
        $0.layer.cornerRadius = 12
        return $0
    }(UIView())
    private let dayLabel = UILabel().style(Theme.Label.Regular.primary)
    private let dayOfWeekLabel = UILabel().style(Theme.Label.Regular.primary)
    
    var dayViewModel: DayViewModel? {
        didSet {
            guard let viewModel = dayViewModel else { return }
            dayLabelCircleView.backgroundColor = viewModel.isSelected ? .red : .clear
            dayLabel.text = viewModel.dayText
            dayOfWeekLabel.text = viewModel.dayOfWeek
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
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
extension DayCell: Setup {
    func addSubviews() {
        addSubview(containerView)
        containerView.addSubview(dayLabelCircleView)
        dayLabelCircleView.addSubview(dayLabel)
        containerView.addSubview(dayOfWeekLabel)
    }
    
    func addConstraints() {
        containerView.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
        dayLabelCircleView.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(4)
            maker.centerX.equalToSuperview()
            maker.width.height.equalTo(24)
        }
        
        dayLabel.snp.makeConstraints { maker in
            maker.centerX.centerY.equalToSuperview()
        }
        
        dayOfWeekLabel.snp.makeConstraints { maker in
            maker.top.equalTo(dayLabelCircleView.snp.bottom).offset(8)
            maker.bottom.equalToSuperview().inset(4)
            maker.centerX.equalToSuperview()
        }
    }
}
