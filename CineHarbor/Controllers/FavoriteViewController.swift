import UIKit
import Mixpanel

class FavoritesViewController: UIViewController {
    private var items: [TrendingItem] = []
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .theme.backgroundColor
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Favorites"
        view.backgroundColor = .theme.backgroundColor
        
        setupCollectionView()
        
        TrendingViewModel.shared.addObserver { [weak self] in
            self?.items = TrendingViewModel.shared.favoriteItems
            self?.collectionView.reloadData()
        }
        
        Mixpanel.mainInstance().track(event: "FavoritesView")
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: TrendingCell.identifier)
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func updateEmptyState() {
        if TrendingViewModel.shared.favoriteItems.isEmpty {
            let messageLabel = UILabel(frame: collectionView.bounds)
            messageLabel.text = "Nenhum favorito ainda ❤️"
            messageLabel.textColor = .white
            messageLabel.textAlignment = .center
            messageLabel.numberOfLines = 0
            
            collectionView.backgroundView = messageLabel
        } else {
            collectionView.backgroundView = nil
        }
    }
}

extension FavoritesViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        updateEmptyState()
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendingCell.identifier,
            for: indexPath
        ) as? TrendingCell else { return UICollectionViewCell() }
        cell.delegate = self
        cell.configure(with: items[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2
        return CGSize(width: width, height: width * 1.6)
    }
}

extension FavoritesViewController: TrendingCellDelegate {
    func trendingCellDidTapFavorite(_ cell: TrendingCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let item = items[indexPath.item]
        TrendingViewModel.shared.toggleFavorite(for: item)
        let dict = [
            "streamTitle": item.title,
            "isFavorite": "\(item.isFavorite)"
        ]
        Mixpanel.mainInstance().track(event: "Tap on favorite", properties: dict)

    }
    
    func trendingCellDidTapDetails(_ cell: TrendingCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        let detailVC = DetailViewController(at: items[indexPath.item])
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
