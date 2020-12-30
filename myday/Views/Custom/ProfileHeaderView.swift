//
//  ProfileHeaderView.swift
//  myday
//
//  Created by Berat Cevik on 12/30/20.
//

import UIKit

class ProfileHeaderView: BaseCollectionReusableView {
    // MARK: - Properties
    private let nameLabel = UILabel().style(Theme.Label.Large.primary)
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            nameLabel.text = user.name ?? "Name: -"
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
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
extension ProfileHeaderView: Setup {
    func addSubviews() {
        addSubview(nameLabel)
    }
    
    func addConstraints() {
        nameLabel.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(24)
        }
    }
}
