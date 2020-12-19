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
    
    private var goalsTableView = UITableView()
    
    // MARK: - Init
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

// MARK: - Setup
extension HomeViewController: Setup {
    func setUpUI() {
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(goalsTableView)
    }
    
    func addConstraints() {
        goalsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
    
    func addObservers() {
        cancellables.insert(viewModel.loadingSubject.sink { [weak self] value in
            print(value)
            self?.goalsTableView.reloadData()
        })
        
        cancellables.insert(viewModel.goalsSubject.sink(receiveCompletion: { error in
            
        }, receiveValue: { [weak self] _ in
            self?.goalsTableView.reloadData()
        }))
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.goals.count)
        return viewModel.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = viewModel.goals[indexPath.row].title
        return cell
    }
}
