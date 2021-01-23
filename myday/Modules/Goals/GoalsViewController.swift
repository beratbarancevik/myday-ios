//
//  GoalsViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/19/20.
//

import Combine
import MaterialComponents.MaterialFeatureHighlight
import UIKit

class GoalsViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: GoalsViewModel
    private var sortViewController: SortViewController?
    
    private let sortBarButtonItem = UIBarButtonItem(image: Image.sort.image, style: .plain, target: nil, action: nil)
    private let addBarButtonItem = UIBarButtonItem(image: Image.add.image, style: .plain, target: nil, action: nil)
    private let goalsTableView: UITableView = {
        $0.style(Theme.Table.primary)
        $0.register(GoalCell.self, forCellReuseIdentifier: GoalCell.identifier)
        $0.register(GoalProgressBarCell.self, forCellReuseIdentifier: GoalProgressBarCell.identifier)
        return $0
    }(UITableView())
    private let refreshControl = UIRefreshControl().style(Theme.RefreshControl.primary)
    private let zeroView = ZeroView(labelText: "You don't have any goals. Let's start by adding your first one.", buttonTitle: "Add Subscription")
//    private let addButton: UIButton = {
//        $0.setImage(Image.addLarge.image, for: .normal)
//        $0.tintColor = .systemBackground
//        $0.backgroundColor = .label
//        $0.layer.cornerRadius = 24
//        return $0
//    }(UIButton(type: .system))
    private let bottomSheetContainerView = UIView()
    
    let didTapSortSubject = PassthroughSubject<Bool, Never>()
    let didSelectGoalSubject = PassthroughSubject<Goal, Never>()
    let didTapAddGoalSubject = PassthroughSubject<Bool, Never>()
    
    // MARK: - Init
    init(viewModel: GoalsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        AnalyticsManager.shared.logEvent(.APP_OPENED)
        setUpUI()
        addSubviews()
        addConstraints()
        addObservers()
        viewModel.getGoals()
    }
}

// MARK: - Private Functions
private extension GoalsViewController {
    func updateUI() {
        let isGoalsEmpty = viewModel.goals.isEmpty
        goalsTableView.setHidden(isGoalsEmpty)
        zeroView.setHidden(!isGoalsEmpty)
        goalsTableView.reloadData()
    }
    
    @objc func didRefresh() {
        viewModel.getGoals()
    }
    
    @objc func sortDidTap() {
//        didTapSortSubject.send(true)
        
//        addChild(sortViewController)
//        bottomSheetContainerView.addSubview(sortViewController.view)
//        UIView.animate(withDuration: 2.0, delay: 0, options: [.curveEaseInOut]) { [weak self] in
//            guard let self = self else { return }
//            self.bottomSheetContainerView.snp.makeConstraints { maker in
//                maker.height.equalTo((48 * 6) + 24)
//            }
//        }
        
        let alertController = UIAlertController(title: "Sort", message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "A to Z", style: .default, handler: { [weak self] _ in
            self?.viewModel.sort(by: .alphabeticAsc)
        }))
        alertController.addAction(UIAlertAction(title: "Z to A", style: .default, handler: { [weak self] _ in
            self?.viewModel.sort(by: .alphabeticDesc)
        }))
//        alertController.addAction(UIAlertAction(title: "Created first", style: .default, handler: { [weak self] _ in
//            self?.viewModel.sort(by: .creationDateAsc)
//        }))
//        alertController.addAction(UIAlertAction(title: "Created last", style: .default, handler: { [weak self] _ in
//            self?.viewModel.sort(by: .creationDateDesc)
//        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController, animated: true)
    }
    
    @objc func addDidTap() {
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
        didTapAddGoalSubject.send(true)
    }
    
    func showTutorial() {
        let displayedButton = UIButton(type: .system)
        displayedButton.setTitle("Got it", for: .normal)
        displayedButton.setTitleColor(.tintColor, for: .normal)
        displayedButton.backgroundColor = .label
        let highlightController = MDCFeatureHighlightViewController(highlightedView: goalsTableView, andShow: displayedButton) { _ in }
        highlightController.titleText = "Just how you want it"
        highlightController.bodyText = "Tap the menu button to switch accounts, change settings & more."
        highlightController.outerHighlightColor = UIColor.tintColor.withAlphaComponent(kMDCFeatureHighlightOuterHighlightAlpha)
        highlightController.innerHighlightColor = .clear
        present(highlightController, animated: true)
    }
}

// MARK: - Setup
extension GoalsViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Goals"
        
        sortBarButtonItem.target = self
        sortBarButtonItem.accessibilityLabel = "sort".localized
        navigationItem.leftBarButtonItem = sortBarButtonItem
        
        addBarButtonItem.target = self
        addBarButtonItem.accessibilityLabel = "add".localized
        navigationItem.rightBarButtonItem = addBarButtonItem
        
        goalsTableView.delegate = self
        goalsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(goalsTableView)
        goalsTableView.addSubview(refreshControl)
        view.addSubview(zeroView)
//        view.addSubview(addButton)
        view.addSubview(bottomSheetContainerView)
    }
    
    func addConstraints() {
        goalsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
        
        zeroView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(safeArea).inset(32)
            maker.bottom.equalTo(safeArea.snp.centerY)
        }
        
//        addButton.snp.makeConstraints { maker in
//            maker.trailing.bottom.equalTo(safeArea).inset(24)
//            maker.width.height.equalTo(48)
//        }
        
        bottomSheetContainerView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func addObservers() {
        sortBarButtonItem.action = #selector(sortDidTap)
        addBarButtonItem.action = #selector(addDidTap)
        
        refreshControl.addTarget(self, action: #selector(didRefresh), for: .valueChanged)
        
        zeroView.mainButtonDidTap = { [weak self] in
            self?.addDidTap()
        }
        
//        addButton.addTarget(self, action: #selector(addDidTap), for: .touchUpInside)
        
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
extension GoalsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        didSelectGoalSubject.send(viewModel.goals[indexPath.row])
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
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteGoal(at: indexPath.row)
        }
    }
}

// MARK: - GoalCellDelegate
extension GoalsViewController: GoalProgressBarCellDelegate {
    func targetDidTap(_ index: Int) {
        viewModel.goals[index].incrementAchieved()
        viewModel.updateGoal(goal: viewModel.goals[index])
        updateUI()
    }
}
