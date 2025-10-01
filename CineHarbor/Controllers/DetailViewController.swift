import UIKit

class DetailViewController: UIViewController {
    var item: TrendingItem
    private let detailView = DetailView()
    
    init(at item: TrendingItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = item.title
        view.backgroundColor = .theme.backgroundColor
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: item.isFavorite ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapFavorite)
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
        
        detailView.configure(with: item)
        
        FavoritesViewModel.shared.addObserver { [weak self] in
            guard let self = self else { return }
            if let updated = FavoritesViewModel.shared.items.first(where: { $0.id == self.item.id }) {
                self.item = updated
                self.detailView.configure(with: updated)
                self.navigationItem.rightBarButtonItem?.image = UIImage(systemName: updated.isFavorite ? "heart.fill" : "heart")
            }
        }
    }
    
    @objc private func didTapFavorite() {
        FavoritesViewModel.shared.toggleFavorite(for: item)
    }
}
