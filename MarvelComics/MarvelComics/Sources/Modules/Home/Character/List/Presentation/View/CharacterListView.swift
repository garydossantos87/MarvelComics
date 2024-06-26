import UIKit

extension Character.List {
    final class View: UIView {
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
                
        func setupDelegates(with dataSource: UITableViewDataSource, delegate: UITableViewDelegate) {
            tableView.dataSource = dataSource
            tableView.delegate = delegate
        }
        
        // MARK: - Private methods -
        
        private func setup() {
            backgroundColor = .white
            addSubview(tableView)
            setupConstraints()
        }
        
        private func setupConstraints() {
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            
        }
    }
}
