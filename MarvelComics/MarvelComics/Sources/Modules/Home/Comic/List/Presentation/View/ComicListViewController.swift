import UIKit

extension Comic.List {
    final class ViewController: UIViewController {
        
        private let comicListView: Comic.List.View
        private let viewModel: Comic.List.ViewModel
        
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
            viewModel.viewDidLoad()
            viewModel.showData = { [weak self] in
                DispatchQueue.main.async {
                    self?.comicListView.reloadData()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Comic.List.CollectionCell.Constants.reuseIdentifier, for: indexPath) as? Comic.List.CollectionViewCell else { return UICollectionViewCell() }
        guard let comicModel = viewModel.comicModel(at: indexPath.item) else { return UICollectionViewCell() }
        cell.configure(with: comicModel)
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
            let columns: CGFloat = 2
            let collectionViewWidth = collectionView.bounds.width
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
            let adjustedWidth = collectionViewWidth - spaceBetweenCells
            let width: CGFloat = adjustedWidth / columns
            let height: CGFloat = 270

//            if indexPath.item % 5 == 0 ||  indexPath.item % 8 == 0  {
//                return CGSize(width: width, height: height + 35)
//            }
            return CGSize(width: width, height: height)
        }
}
