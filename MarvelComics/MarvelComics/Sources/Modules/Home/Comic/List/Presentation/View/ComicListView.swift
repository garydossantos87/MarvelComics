import UIKit

extension Comic.List {
    final class View: UIView {
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(
                top: .zero,
                left: Constants.cellPadding,
                bottom: .zero,
                right: Constants.cellPadding
            )
            layout.minimumInteritemSpacing = Constants.cellPadding
            layout.minimumLineSpacing = Constants.cellPadding
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(
                Comic.List.CollectionViewCell.self,
                forCellWithReuseIdentifier: Comic.List.CollectionViewCell.Constants.reuseIdentifier
            )
            collectionView.accessibilityIdentifier = AccessibilityIdentifiers.Comic.collectionViewID
            return collectionView
        }()
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
        
        func reloadData() {
            collectionView.reloadData()
        }
        
        func setupDelegates(with dataSource: UICollectionViewDataSource, delegate: UICollectionViewDelegate) {
            collectionView.dataSource = dataSource
            collectionView.delegate = delegate
        }
        
        private func setup() {
            backgroundColor = .white
            addSubview(collectionView)
            setupConstraints()
        }
        
        private func setupConstraints() {
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
}
