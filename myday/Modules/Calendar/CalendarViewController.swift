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
        $0.register(DayCell.self, forCellWithReuseIdentifier: DayCell.identifier)
        $0.tag = 0
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
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
    }
}

// MARK: - Private Functions
private extension CalendarViewController {
    
}

// MARK: - Setup
extension CalendarViewController: Setup {
    func setUpUI() {
        navigationItem.title = Date().calendarTitle
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        daysCollectionView.setCollectionViewLayout(flowLayout, animated: false)
//        daysCollectionView.delegate = self
//        daysCollectionView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(separatorView1)
        view.addSubview(daysCollectionView)
        view.addSubview(separatorView2)
    }
    
    func addConstraints() {
        separatorView1.snp.makeConstraints { maker in
            maker.top.leading.trailing.equalTo(safeArea)
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
    }
    
    func addObservers() {
        
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
//extension CalendarViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        switch collectionView.tag {
//        case 0:
//            generateSelectionHaptic()
//        case 1:
//            present(BaseNavigationController(rootViewController: GoalDetailController()), animated: true)
//        default:
//            break
//        }
//        collectionView.deselectItem(at: indexPath, animated: true)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        switch collectionView.tag {
//        case 0:
//            return dayViewModels.count
//        case 1:
//            return goalViewModels.count
//        default:
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        switch collectionView.tag {
//        case 0:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.identifier, for: indexPath) as? DayCell else { return UICollectionViewCell() }
//            cell.dayViewModel = dayViewModels[indexPath.row]
//            return cell
//        case 1:
//            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoalCell.identifier, for: indexPath) as? GoalCell else { return UICollectionViewCell() }
//            cell.goalViewModel = goalViewModels[indexPath.row]
//            return cell
//        default:
//            return UICollectionViewCell()
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch collectionView.tag {
//        case 0:
//            return CGSize(width: 50, height: 80)
//        case 1:
//            let width = collectionView.frame.width - 32
//            return CGSize(width: width, height: 96)
//        default:
//            return .zero
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        switch collectionView.tag {
//        case 0:
//            return .zero
//        case 1:
//            return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        default:
//            return .zero
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        switch collectionView.tag {
//        case 0:
//            return 0
//        case 1:
//            return 16
//        default:
//            return 0
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        switch collectionView.tag {
//        case 0:
//            return 0
//        case 1:
//            return 16
//        default:
//            return 0
//        }
//    }
//}
