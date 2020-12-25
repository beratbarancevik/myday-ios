//
//  SettingsViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class SettingsViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: SettingsViewModel
    
    private let settingsTableView: UITableView = {
        $0.register(SettingCell.self, forCellReuseIdentifier: SettingCell.identifier)
        $0.register(VersionFooterView.self, forHeaderFooterViewReuseIdentifier: VersionFooterView.identifier)
        $0.accessibilityLabel = "settings_table_view".localized
        $0.backgroundColor = .secondarySystemBackground
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    // MARK: - Init
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        addSubviews()
        addConstraints()
    }
}

// MARK: - Setup
extension SettingsViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Settings"
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(settingsTableView)
    }
    
    func addConstraints() {
        settingsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch viewModel.settings[indexPath.section][indexPath.row] {
        default:
            break
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.identifier, for: indexPath) as? SettingCell else { return UITableViewCell() }
        cell.settingType = viewModel.settings[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == viewModel.settings.count - 1 {
            guard let versionFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: VersionFooterView.identifier) as? VersionFooterView else { return nil }
            return versionFooterView
        }
        return nil
    }
}
