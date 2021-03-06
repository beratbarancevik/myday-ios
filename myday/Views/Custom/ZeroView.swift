//
//  ZeroView.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class ZeroView: BaseView {
    // MARK: - Properties
    private let titleLabel: UILabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        return $0
    }(UILabel().style(Theme.Label.Large.primary))
    private let mainButton: UIButton = {
        $0.layer.cornerRadius = 24
        return $0
    }(UIButton(type: .system).style(Theme.Button.primary))
    
    var mainButtonDidTap: (() -> Void)?
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
        addSubviews()
        addConstraints()
        addObservers()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpUI()
        addSubviews()
        addConstraints()
        addObservers()
    }
    
    convenience init(labelText: String, buttonTitle: String) {
        self.init(frame: .zero)
        updateUI(labelText, buttonTitle)
    }
    
    // MARK: - Functions
    func updateUI(_ labelText: String, _ buttonTitle: String) {
        titleLabel.text = labelText
        mainButton.setTitle(buttonTitle, for: .normal)
    }
}

// MARK: - Private
private extension ZeroView {
    @objc func mainDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        mainButtonDidTap?()
    }
}

// MARK: - Setup
extension ZeroView: Setup {
    func setUpUI() {
        isHidden = true
    }
    
    func addSubviews() {
        addSubview(titleLabel)
        addSubview(mainButton)
    }
    
    func addConstraints() {
        titleLabel.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
        }
        
        mainButton.snp.makeConstraints { maker in
            maker.top.equalTo(titleLabel.snp.bottom).offset(48)
            maker.leading.trailing.bottom.equalToSuperview()
            maker.height.equalTo(48)
        }
    }
    
    func addObservers() {
        mainButton.addTarget(self, action: #selector(mainDidTap), for: .touchUpInside)
    }
}
