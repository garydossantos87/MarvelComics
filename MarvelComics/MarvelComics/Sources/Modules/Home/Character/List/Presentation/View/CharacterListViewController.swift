import UIKit

extension Character.List {
    final class ViewController: UIViewController {
        
        private let characterListView: Character.List.View
        private let viewModel: Character.List.ViewModel
        
        init(with viewModel: Character.List.ViewModel) {
            self.viewModel = viewModel
            characterListView = Character.List.View()
            super.init(nibName: nil, bundle: nil)
            setupTableView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = characterListView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
    }
}

// MARK: - Private methods -

private extension Character.List.ViewController {
    func setupTableView() {
        characterListView.setupDelegates(with: self, delegate: self)
    }
}

// MARK: - UITableViewDataSource -

extension Character.List.ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Character.List.ViewCell.Constants.reuseIdentifier) as? Character.List.ViewCell else { fatalError("Cell not initialized properly") }
        
        tableViewCell.configure()
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
}

// MARK: - UITableViewDelegate -

extension Character.List.ViewController: UITableViewDelegate {
}

