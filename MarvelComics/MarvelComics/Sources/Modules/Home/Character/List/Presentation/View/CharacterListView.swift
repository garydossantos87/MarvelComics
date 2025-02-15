import UIKit

extension Character.List {
    final class View: UIView {
        private let searchBar: UISearchBar = {
            let searchBar = UISearchBar()
            searchBar.placeholder = Constants.searchBarTitle
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            searchBar.backgroundImage = UIImage()
            searchBar.accessibilityIdentifier = AccessibilityIdentifiers.Character.searchBarViewID
            return searchBar
        }()
        
        private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.rowHeight = UITableView.automaticDimension
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.isScrollEnabled = true
            tableView.bounces = false
            tableView.autoresizingMask = .flexibleHeight
            tableView.register(Character.List.ViewCell.self, forCellReuseIdentifier: Character.List.ViewCell.Constants.reuseIdentifier)
            tableView.tableHeaderView = UIView()
            tableView.showsVerticalScrollIndicator = false
            tableView.accessibilityIdentifier = AccessibilityIdentifiers.Character.tableViewID
            return tableView
        }()
        
        // MARK: - Init -
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        // MARK: - Public methods -
        
        func reloadData() {  
            tableView.reloadData()
        }
                
        func setupDelegates(
            with dataSource: UITableViewDataSource,
            delegate: UITableViewDelegate,
            searchBarDelegate: UISearchBarDelegate
        ) {
            tableView.dataSource = dataSource
            tableView.delegate = delegate
            searchBar.delegate = searchBarDelegate
        }
        
        // MARK: - Private methods -
        
        private func setup() {
            backgroundColor = .white
            addSubview(searchBar)
            addSubview(tableView)
            setupConstraints()
        }
        
        private func setupConstraints() {
            NSLayoutConstraint.activate([
                searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.searchBarPadding),
                searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.searchBarPadding)
            ])
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
                tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
    }
}
