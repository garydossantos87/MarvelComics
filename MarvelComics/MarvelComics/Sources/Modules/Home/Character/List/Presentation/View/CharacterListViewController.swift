import UIKit
import Combine

extension Character.List {
    final class ViewController: UIViewController {
        private let characterListView: Character.List.View
        private let viewModel: Character.List.ViewModel
        private var cancellables: Set<AnyCancellable> = []

        init(with viewModel: Character.List.ViewModel) {
            self.viewModel = viewModel
            characterListView = Character.List.View()
            super.init(nibName: nil, bundle: nil)
            setupTableView()
            bindViewModel()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = characterListView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.viewDidLoad()
        }
    }
}

// MARK: - Private methods -

private extension Character.List.ViewController {
    func setupTableView() {
        characterListView.setupDelegates(with: self, delegate: self)
    }

    func bindViewModel() {
        cancellables.cancelAll()
        viewModel.$state
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.characterListView.reloadData()
                    self?.hideLoading()
                case .failure(let error):
                    self?.showAlert(with: .defaultError(
                        with: error.localizedDescription,
                        actionHandler: { [weak self] in
                            self?.hideAlert()
                        }
                    ))
                    self?.hideLoading()
                case .loading:
                    self?.showLoading()
                case .none: break
                }
            }
            .store(in: &cancellables)

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
            viewModel.loadData()
        }
    }
}

// MARK: - UITableViewDelegate -

extension Character.List.ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.onCharacterClicked(position: indexPath.row)
    }
}
