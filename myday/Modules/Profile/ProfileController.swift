//
//  ProfileController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine
import UIKit

class ProfileController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ProfileViewModel
    
    private let settingsBarButtonItem = UIBarButtonItem(image: Image.settings.image, style: .plain, target: nil, action: nil)
    private let profileCollectionView: UICollectionView = {
        $0.style(Theme.Collection.primary)
        $0.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderView.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    private let refreshControl = UIRefreshControl().style(Theme.RefreshControl.primary)
    
    // MARK: - Init
    init(viewModel: ProfileViewModel) {
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
        viewModel.getUser()
    }
}

// MARK: - Private Functions
private extension ProfileController {
    @objc func settingsDidTap() {
        navigationController?.pushViewController(SettingsViewController(viewModel: SettingsViewModel()), animated: true)
    }
    
    func updateUI() {
        profileCollectionView.reloadData()
    }
}

// MARK: - Setup
extension ProfileController: Setup {
    func setUpUI() {
        navigationItem.title = "Profile"
        
        settingsBarButtonItem.target = self
        settingsBarButtonItem.accessibilityLabel = "settings".localized
        navigationItem.rightBarButtonItem = settingsBarButtonItem
        
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(profileCollectionView)
        profileCollectionView.addSubview(refreshControl)
    }
    
    func addConstraints() {
        profileCollectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
    
    func addObservers() {
        settingsBarButtonItem.action = #selector(settingsDidTap)
        
        cancellables.insert(viewModel.loadingSubject.sink { [weak self] value in
            value ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
        })
        
        cancellables.insert(viewModel.userSubject.sink(receiveCompletion: { _ in
        }, receiveValue: { [weak self] _ in
            self?.updateUI()
        }))
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderView.identifier, for: indexPath) as? ProfileHeaderView else { return UICollectionReusableView() }
        headerView.user = viewModel.user
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: profileCollectionView.frame.width, height: 100)
    }
}
