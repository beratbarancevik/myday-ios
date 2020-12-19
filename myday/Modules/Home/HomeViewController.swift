//
//  HomeViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import UIKit

class HomeViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: HomeViewModel
    
    private let goalsTableView: UITableView = {
        $0.style(Theme.Table.primary)
        $0.register(GoalCell.self, forCellReuseIdentifier: GoalCell.identifier)
        return $0
    }(UITableView())
    private let refreshControl = UIRefreshControl().style(Theme.RefreshControl.primary)
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
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
        
        viewModel.getGoals()
    }
}

// MARK: - Private Functions
private extension HomeViewController {
    @objc func didRefresh() {
        viewModel.getGoals()
    }
}

// MARK: - Setup
extension HomeViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Home"
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(goalsTableView)
        goalsTableView.addSubview(refreshControl)
    }
    
    func addConstraints() {
        goalsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
    
    func addObservers() {
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        
        cancellables.insert(viewModel.loadingSubject.sink { [weak self] value in
            value ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
        })
        
        cancellables.insert(viewModel.goalsSubject.sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] _ in
            self?.goalsTableView.reloadData()
        }))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as? GoalCell else { return UITableViewCell() }
        cell.goal = viewModel.goals[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteGoal(at: indexPath.row)
        }
    }
}
