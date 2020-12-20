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
    private let zeroView = ZeroView(labelText: "You don't have any goals. Let's start by adding your first one.", buttonTitle: "Add Subscription")
    
    let didSelectGoal = PassthroughSubject<Goal, Never>()
    let addGoal = PassthroughSubject<Bool, Never>()
    
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
    func updateUI() {
        let isGoalsEmpty = viewModel.goals.isEmpty
        goalsTableView.setHidden(isGoalsEmpty)
        zeroView.setHidden(!isGoalsEmpty)
        goalsTableView.reloadData()
    }
    
    @objc func didRefresh() {
        viewModel.getGoals()
    }
    
    @objc func addDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        addGoal.send(true)
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
        view.addSubview(zeroView)
    }
    
    func addConstraints() {
        goalsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
        
        zeroView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(safeArea).inset(32)
            maker.bottom.equalTo(safeArea.snp.centerY)
        }
    }
    
    func addObservers() {
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        
        zeroView.mainButtonDidTap = { [weak self] in
            self?.addDidTap()
        }
        
        cancellables.insert(viewModel.loadingSubject.sink { [weak self] value in
            value ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
        })
        
        cancellables.insert(viewModel.goalsSubject.sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] _ in
            self?.updateUI()
        }))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        didSelectGoal.send(viewModel.goals[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
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
