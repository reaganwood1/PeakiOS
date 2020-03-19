//
//  GoalCollectionViewController.swift
//  Summit
//
//  Created by Reagan Wood on 3/15/20.
//  Copyright © 2020 Reagan Wood. All rights reserved.
//

import UIKit
import IGListKit

class GoalCollectionViewController: GenericViewController<GoalCollectionView> {
    private var adapter: ListAdapter?

    private var goals = [Goal]()
    private var filteredGoals = [Goal]()
    
    private let goalService: IGoalService
    
    init(goalService: IGoalService = GoalService()) {
        self.goalService = goalService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        hideNavBar()
        contentView.searchBarDelegate = self
        loadGoals()
    }
    
    private func setupCollectionView() {
        let updater = ListAdapterUpdater()
        let adapter = ListAdapter(updater: updater, viewController: self)
        adapter.collectionView = contentView.collectionView
        adapter.dataSource = self
        self.adapter = adapter
    }
    
    private func hideNavBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    private func loadGoals() {
        goalService.getGoals { [weak self] (result) in
            switch result {
            case .success(let goals):
                self?.goals = goals
                self?.filteredGoals = goals
                self?.adapter?.performUpdates(animated: true, completion: nil)
            case .failure(let error):
                break // TODO: handle the error
            }
        }
    }
}

extension GoalCollectionViewController: UISearchBarDelegate {
    private func reloadCollection() {
        adapter?.performUpdates(animated: true, completion: nil)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredGoals = goals
        } else {
            filteredGoals = goals.filter({ $0.title.contains(searchText) })
        }
        reloadCollection()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        reloadCollection()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension GoalCollectionViewController: ListAdapterDataSource {
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return filteredGoals
    }

    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return GoalSectionController()
    }

    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        return nil
    }
}

class GoalSectionController: ListSectionController {
    private var goal: Goal? = nil
    
    override init() {
        super.init()
        self.inset = UIEdgeInsets(top: 20.0, left: 0, bottom: 0.0, right: 0.0)
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        let offset: CGFloat = 40
        return CGSize(width: UIScreen.main.bounds.width - offset, height: 80.0)
    }
    
    override func numberOfItems() -> Int {
        return 1
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell: GoalCollectionViewCell = collectionContext?.dequeueReusableCell(of: GoalCollectionViewCell.self, for: self, at: index) as? GoalCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let goal = goal else { return cell }
        
        cell.set(titleTo: goal.title, andSubtitleTo: "25 goals!")
        
        return cell
    }
    
    override func didUpdate(to object: Any) {
        super.didUpdate(to: object)
        if let object = object as? Goal {
            goal = object
        }
    }
}

class GoalCollectionView: GenericView {
    weak public var searchBarDelegate: UISearchBarDelegate? {
        didSet {
            searchBar.delegate = searchBarDelegate
        }
    }
    
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .darkGray
            textfield.backgroundColor = .offWhite
        }
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.offWhite], for: .normal)
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        return searchBar
    }()
    
    private var collectionViewInsetFromTop: CGFloat = 50.0
    
    public let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .backgroundBlack
        return collectionView
    }()
    
    override func initializeUI() {
        super.initializeUI()
        addAllSubviews([collectionView, searchBar])
        changeTopCollectionViewInsets()
    }
    
    override func createConstraints() {
        super.createConstraints()
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        createSearchBarConstraints()
    }
    
    private func createSearchBarConstraints() {
        searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    private func changeTopCollectionViewInsets() {
        collectionView.contentInset.top = collectionViewInsetFromTop
    }
}

class GoalCollectionViewCell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = .offWhite
        titleLabel.font = .systemFont(ofSize: 16.0, weight: .bold)
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.textColor = .offWhite
        subtitleLabel.font = .systemFont(ofSize: 14.0, weight: .medium)
        return subtitleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeUI()
    }
    
    private func initializeUI() {
        backgroundColor = .objectBlack
        addAllSubviews([titleLabel, subtitleLabel])
        createConstraints()
        roundCorners()
    }
    
    private func roundCorners() {
        layer.cornerRadius = 10.0
    }
    
    private func createConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().inset(20)
            make.top.equalToSuperview().inset(15)
        }
        
        subtitleLabel.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(15)
            make.left.equalTo(titleLabel.snp.left)
        }
    }
    
    public func set(titleTo title: String, andSubtitleTo subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}