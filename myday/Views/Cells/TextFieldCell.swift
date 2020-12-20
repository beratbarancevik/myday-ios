//
//  TextFieldCell.swift
//  myday
//
//  Created by Berat Cevik on 12/20/20.
//

import UIKit

protocol TextFieldCellDelegate: AnyObject {
    func textFieldDidChange(_ type: GoalDetail, _ text: String)
}

class TextFieldCell: BaseTableCell {
    // MARK: - Properties
    private let textField = UITextField().style(Theme.TextField.primary)
    
    weak var delegate: TextFieldCellDelegate?
    
    private var type = GoalDetail.title
    private var value: String?
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
    
    // MARK: - Functions
    func updateUI(_ type: GoalDetail, text: String?) {
        self.type = type
        textField.text = value
        textField.placeholder = type.placeholder
        textField.text = text
        
        switch type {
        case .title:
            textField.keyboardType = .default
        }
    }
}

// MARK: - Private Functions
private extension TextFieldCell {
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        delegate?.textFieldDidChange(type, text)
    }
}

// MARK: - Setup
extension TextFieldCell: Setup {
    func setUpUI() {
        contentView.backgroundColor = .secondarySystemBackground
    }
    
    func addSubviews() {
        addSubview(textField)
    }
    
    func addConstraints() {
        textField.snp.makeConstraints { maker in
            maker.top.bottom.equalToSuperview().inset(16)
            maker.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    func addObservers() {
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
}
