//
//  SortViewController.swift
//  myday
//
//  Created by Berat Cevik on 1/1/21.
//

import UIKit

protocol SortViewControllerDelegate: AnyObject {
    func didSelectSortOption(_ sortOption: SortOption)
}

class SortViewController: BaseViewController {
    // MARK: - Properties
    private let viewModel: SortViewModel
    
    private let dragView: UIView = {
        $0.backgroundColor = .secondarySystemBackground
        return $0
    }(UIView())
    private let dragIconView: UIView = {
        $0.backgroundColor = .label
        $0.layer.cornerRadius = 2
        return $0
    }(UIView())
    private let optionsTableView: UITableView = {
        $0.backgroundColor = .secondarySystemBackground
        $0.alwaysBounceVertical = false
        $0.register(SortOptionCell.self, forCellReuseIdentifier: SortOptionCell.identifier)
        return $0
    }(UITableView())
    
    weak var delegate: SortViewControllerDelegate?
    
    // MARK: - Init
    init(viewModel: SortViewModel) {
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
        optionsTableView.reloadData()
    }
}

// MARK: - Private Functions
private extension SortViewController {
    
}

// MARK: - Setup
extension SortViewController: Setup {
    func setUpUI() {
        optionsTableView.delegate = self
        optionsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(dragView)
        dragView.addSubview(dragIconView)
        view.addSubview(optionsTableView)
    }
    
    func addConstraints() {
        dragView.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalToSuperview()
            maker.height.equalTo(24)
        }

        dragIconView.snp.makeConstraints { maker in
            maker.width.equalTo(32)
            maker.height.equalTo(4)
            maker.centerX.centerY.equalToSuperview()
        }
        
        optionsTableView.snp.makeConstraints { maker in
            maker.top.equalTo(dragView.snp.bottom)
            maker.leading.trailing.bottom.equalToSuperview()
//            maker.height.equalTo((48 * 6))
        }
        
        view.layoutIfNeeded()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SortViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectSortOption(viewModel.sortOptions[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SortOptionCell.identifier, for: indexPath) as? SortOptionCell else { return UITableViewCell() }
        cell.sortOption = viewModel.sortOptions[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
}
