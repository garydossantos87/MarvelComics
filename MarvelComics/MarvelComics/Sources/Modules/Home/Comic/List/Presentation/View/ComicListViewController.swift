import UIKit
import Combine

extension Comic.List {
    final class ViewController: UIViewController {
        private let comicListView: Comic.List.View
        private let viewModel: Comic.List.ViewModel
        private var cancellables: Set<AnyCancellable> = []

        // MARK: - Init -

        init(with viewModel: Comic.List.ViewModel) {
            self.viewModel = viewModel
            comicListView = Comic.List.View()
            super.init(nibName: nil, bundle: nil)
            setupCollectionView()
            bindViewModel()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        override func loadView() {
            self.view = comicListView
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            viewModel.viewDidLoad()
        }
    }
}

// MARK: - Private methods -

private extension Comic.List.ViewController {
    func setupCollectionView() {
        comicListView.setupDelegates(with: self, delegate: self)
    }

    func bindViewModel() {
        cancellables.cancelAll()
        viewModel.$state
            .sink { [weak self] result in
                switch result {
                case .success:
                    self?.comicListView.reloadData()
                    self?.hideLoading()
                case .failure(let error):
                    self?.showAlert(with: .defaultError(
                        with: error.name,
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

// MARK: - UICollectionViewDataSource -

extension Comic.List.ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Comic.List.CollectionViewCell.Constants.reuseIdentifier, for: indexPath) as? Comic.List.CollectionViewCell else { return UICollectionViewCell() }
        guard let model = viewModel.comicModel(at: indexPath.item) else { return UICollectionViewCell() }
        cell.configure(with: model)
        return cell
    }
}

// MARK: - UICollectionViewDelegate -

extension Comic.List.ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.onComicClicked(at: indexPath.item)
    }
}


// MARK: - UICollectionViewDelegateFlowLayout -

extension Comic.List.ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let paddingSpace = Comic.List.View.Constants.cellPadding * (numberOfColumns + 1)
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / numberOfColumns
        let heightPerItem = widthPerItem * 1.5
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
