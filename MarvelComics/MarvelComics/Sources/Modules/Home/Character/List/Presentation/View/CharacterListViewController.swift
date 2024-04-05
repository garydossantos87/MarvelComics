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
            loadData()
            viewModel.showData = { [weak self] in
                DispatchQueue.main.async {
                    self?.characterListView.reloadData()
                    self?.hideLoading()
                }
            }
            viewModel.showError = { [weak self] error in
                // TODO: Create emptyList for retry the call
                DispatchQueue.main.async {
                    self?.hideLoading()
                    self?.showAlert(with: .defaultError(
                        with: error,
                        actionHandler: { [weak self] in
                            self?.hideAlert()
                        }))
                }
            }
        }
    }
}

// MARK: - Private methods -

private extension Character.List.ViewController {
    func loadData() {
        showLoading()
        viewModel.loadData()
    }
    func setupTableView() {
        characterListView.setupDelegates(with: self, delegate: self)
    }
}

// MARK: - UITableViewDataSource -

extension Character.List.ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Character.List.ViewCell.Constants.reuseIdentifier) as? Character.List.ViewCell else { fatalError("Cell not initialized properly") }
        guard let model = viewModel.characterModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        tableViewCell.configure(with: model)
        tableViewCell.selectionStyle = .none
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = viewModel.numberOfRowsInSection(section: 1) - 1
        if indexPath.row >= lastItem {
            loadData()
        }
    }
}

// MARK: - UITableViewDelegate -

extension Character.List.ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected")
    }
}
