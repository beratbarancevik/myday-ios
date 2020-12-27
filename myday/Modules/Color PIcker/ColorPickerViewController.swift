//
//  ColorPickerViewController.swift
//  myday
//
//  Created by Berat Cevik on 12/24/20.
//

import Combine
import UIKit

class ColorPickerViewController: BaseViewController {
    // MARK: - Properties
    private var viewModel: ColorPickerViewModel
    
    private let colorsTableView: UITableView = {
        $0.register(ColorCell.self, forCellReuseIdentifier: ColorCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .plain).style(Theme.Table.primary))
    
    let didPickColorSubject = PassthroughSubject<GoalColor, Never>()
    
    // MARK: - Init
    init(viewModel: ColorPickerViewModel) {
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
    }
}

// MARK: - Setup
extension ColorPickerViewController: Setup {
    func setUpUI() {
        navigationItem.title = "Color"
        
        colorsTableView.delegate = self
        colorsTableView.dataSource = self
    }
    
    func addSubviews() {
        view.addSubview(colorsTableView)
    }
    
    func addConstraints() {
        colorsTableView.snp.makeConstraints { maker in
            maker.edges.equalTo(safeArea)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ColorPickerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didPickColorSubject.send(viewModel.colors[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.colors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ColorCell.identifier, for: indexPath) as? ColorCell else { return UITableViewCell() }
        cell.title = viewModel.colors[indexPath.row].name
        cell.goalColor = viewModel.colors[indexPath.row]
        return cell
    }
}
