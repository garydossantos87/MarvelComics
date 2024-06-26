import UIKit

extension Comic.List {
    final class ViewController: UIViewController {
        
        private let comicListView: Comic.List.View
        private let viewModel: Comic.List.ViewModel
        
        // MARK: - Init - 
        
        init(with viewModel: Comic.List.ViewModel) {
            self.viewModel = viewModel
            comicListView = Comic.List.View()
            super.init(nibName: nil, bundle: nil)
            setupCollectionView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func loadView() {
            self.view = comicListView
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            showLoading()
            viewModel.viewDidLoad()
            viewModel.showData = { [weak self] in
                DispatchQueue.main.async {
                    self?.comicListView.reloadData()
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

private extension Comic.List.ViewController {
    func setupCollectionView() {
        comicListView.setupDelegates(with: self, delegate: self)
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
        print("Selected")
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
