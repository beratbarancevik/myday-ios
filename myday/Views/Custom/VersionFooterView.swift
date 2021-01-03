//
//  VersionFooterView.swift
//  myday
//
//  Created by Berat Cevik on 12/25/20.
//

import UIKit

class VersionFooterView: BaseTableHeaderFooterView {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        $0.style(Theme.Label.Regular.primary)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
extension VersionFooterView: Setup {
    func setUpUI() {
        contentView.backgroundColor = .clear
        titleLabel.text = "Version: \(Utility.shared.appVersion)"
    }
    
    func addSubviews() {
        addSubview(titleLabel)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(24)
        }
    }
}
