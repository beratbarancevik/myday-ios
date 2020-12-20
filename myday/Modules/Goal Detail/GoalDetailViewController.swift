//
//  GoalDetailViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import UIKit

class GoalDetailViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: GoalDetailViewModel
    
    private let saveBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
    private let detailsTableView: UITableView = {
        $0.register(TextFieldCell.self, forCellReuseIdentifier: TextFieldCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .grouped).style(Theme.Table.primary))
    
    // MARK: - Init
    init(viewModel: GoalDetailViewModel) {
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
        addObservers()
    }
}

// MARK: - Private Functions
private extension GoalDetailViewController {
    @objc func saveDidTap() {
        viewModel.saveSubscription()
    }
}

// MARK: - Setup
extension GoalDetailViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Goal"
        
        saveBarButtonItem.target = self
        navigationItem.rightBarButtonItem = saveBarButtonItem
        
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(detailsTableView)
    }
    
    func addConstraints() {
        detailsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
    
    func addObservers() {
        saveBarButtonItem.action = #selector(saveDidTap)
        
        cancellables.insert(viewModel.didSaveSubject.sink(receiveCompletion: { _ in
        }, receiveValue: { _ in
            NotificationCenter.default.post(name: .didSaveGoal, object: nil)
        }))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension GoalDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GoalDetail.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldCell.identifier, for: indexPath) as? TextFieldCell else { return UITableViewCell() }
        cell.delegate = self
        switch GoalDetail.allCases[indexPath.row] {
        case .title:
            cell.updateUI(.title, text: viewModel.goal.title)
        }
        return cell
    }
}

// MARK: - TextFieldCellDelegate
extension GoalDetailViewController: TextFieldCellDelegate {
    func textFieldDidChange(_ type: GoalDetail, _ text: String) {
        switch type {
        case .title:
            viewModel.goal.title = text
        }
    }
}
