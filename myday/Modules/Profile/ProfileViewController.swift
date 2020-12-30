//
//  ProfileViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine
import UIKit

class ProfileViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ProfileViewModel
    
    private let settingsBarButtonItem = UIBarButtonItem(image: Image.settings.image, style: .plain, target: nil, action: nil)
    private let profileCollectionView: UICollectionView = {
        $0.style(Theme.Collection.primary)
        $0.register(ProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ProfileHeaderView.identifier)
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    let didTapSettingsSubject = PassthroughSubject<Bool, Never>()
    
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
    }
}

// MARK: - Private Functions
private extension ProfileViewController {
    @objc func settingsDidTap() {
        didTapSettingsSubject.send(true)
    }
}

// MARK: - Setup
extension ProfileViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Profile"
        
        settingsBarButtonItem.target = self
        settingsBarButtonItem.accessibilityLabel = "settings".localized
        navigationItem.rightBarButtonItem = settingsBarButtonItem
    }
    
    func addSubviews() {
        view.addSubview(profileCollectionView)
    }
    
    func addConstraints() {
        profileCollectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
    
    func addObservers() {
        settingsBarButtonItem.action = #selector(settingsDidTap)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
}
