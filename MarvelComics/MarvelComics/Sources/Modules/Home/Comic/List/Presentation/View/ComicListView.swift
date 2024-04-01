import UIKit

extension Comic.List {
    final class View: UIView {
        
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.backgroundColor = .white
            collectionView.translatesAutoresizingMaskIntoConstraints = false
//            collectionView.isScrollEnabled = true
//            collectionView.bounces = false
//            collectionView.autoresizingMask = .flexibleHeight
//            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(Comic.List.CollectionViewCell.self, forCellWithReuseIdentifier: CollectionCell.Constants.reuseIdentifier)
            return collectionView
        }()
        
        init() {
            super.init(frame: .zero)
            setup()
        }
        
        @available(*, unavailable)
        required init?(coder: NSCoder) { preconditionFailure("Error") }
        
        func configure() {
        }
        
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
