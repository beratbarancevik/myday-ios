//
//  CalendarViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/23/20.
//

import UIKit

class CalendarViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: CalendarViewModel
    
    private let separatorView1: UIView = {
        $0.backgroundColor = .label
        return $0
    }(UIView())
    private let daysCollectionView: UICollectionView = {
        $0.isDirectionalLockEnabled = true
        $0.alwaysBounceHorizontal = true
        $0.alwaysBounceVertical = false
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .systemBackground
        $0.register(DayCell.self, forCellWithReuseIdentifier: DayCell.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    private let goalsTableView: UITableView = {
        $0.style(Theme.Table.primary)
        $0.register(GoalCell.self, forCellReuseIdentifier: GoalCell.identifier)
        $0.register(GoalProgressBarCell.self, forCellReuseIdentifier: GoalProgressBarCell.identifier)
        return $0
    }(UITableView())
    private let refreshControl = UIRefreshControl().style(Theme.RefreshControl.primary)
    private let separatorView2: UIView = {
        $0.backgroundColor = .label
        return $0
    }(UIView())
    
    // MARK: - Init
    init(viewModel: CalendarViewModel) {
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
private extension CalendarViewController {
    func updateUI() {
        daysCollectionView.reloadData()
        goalsTableView.reloadData()
    }
}

// MARK: - Setup
extension CalendarViewController: Setup {
    func setUpUI() {
        navigationItem.title = Date().calendarTitle
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        daysCollectionView.setCollectionViewLayout(flowLayout, animated: false)
        daysCollectionView.delegate = self
        daysCollectionView.dataSource = self
        
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(goalsTableView)
        goalsTableView.addSubview(refreshControl)
        view.addSubview(separatorView1)
        view.addSubview(daysCollectionView)
        view.addSubview(separatorView2)
    }
    
    func addConstraints() {
        separatorView1.snp.makeConstraints { maker in
            maker.top.equalTo(safeArea).inset(16)
            maker.leading.trailing.equalTo(safeArea)
            maker.height.equalTo(1)
        }
        
        daysCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(separatorView1.snp.bottom)
            maker.leading.trailing.equalTo(safeArea)
            maker.height.equalTo(80)
        }
        
        separatorView2.snp.makeConstraints { maker in
            maker.top.equalTo(daysCollectionView.snp.bottom)
            maker.leading.trailing.equalTo(safeArea)
            maker.height.equalTo(1)
        }
        
        goalsTableView.snp.makeConstraints { maker in
            maker.top.equalTo(separatorView2.snp.bottom)
            maker.leading.trailing.bottom.equalTo(safeArea)
        }
    }
    
    func addObservers() {
        cancellables.insert(viewModel.loadingSubject.sink { [weak self] value in
            value ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
        })
        
        cancellables.insert(viewModel.goalsSubject.sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] _ in
            self?.updateUI()
        }))
    }
}

// MARK: - Private Extension
private extension CalendarViewController {
    
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dayViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.identifier, for: indexPath) as? DayCell else { return UICollectionViewCell() }
        cell.dayViewModel = viewModel.dayViewModels[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 80)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

// MARK: -
extension CalendarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let goal = viewModel.goals[indexPath.row]
        if goal.target == nil {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalCell.identifier, for: indexPath) as? GoalCell else { return UITableViewCell() }
            cell.index = indexPath.row
            cell.goal = viewModel.goals[indexPath.row]
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GoalProgressBarCell.identifier, for: indexPath) as? GoalProgressBarCell else { return UITableViewCell() }
            cell.index = indexPath.row
            cell.goal = viewModel.goals[indexPath.row]
            return cell
        }
    }
}
