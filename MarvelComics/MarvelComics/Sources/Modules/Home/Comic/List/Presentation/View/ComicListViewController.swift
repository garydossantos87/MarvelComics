import UIKit

extension Comic.List {
    final class ViewController: UIViewController {
        
        private let comicListView: Comic.List.View
        private let viewModel: Comic.List.ViewModel
        
        init(with viewModel: Comic.List.ViewModel) {
            self.viewModel = viewModel
            comicListView = Comic.List.View()
            
            super.init(nibName: nil, bundle: nil)
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

//// MARK: - UICollectionViewDataSource -
//
//extension Comic.List.ViewController: UICollectionViewDataSource {
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 5
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else {
//            return UICollectionViewCell()
//        }
//        
//        let photo = sections[indexPath.section].items[indexPath.item]
//        cell.viewModel = PhotoCell.ViewModel(identifier: photo.identifier, imageURL: photo.thumbnailURL)
//        
//    }
//}
