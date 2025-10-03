import Foundation

final class TrendingViewModel {
    static let shared = TrendingViewModel()
    
    private(set) var items: [TrendingItem] = []
    
    private var observers: [() -> Void] = []
    
    private init() {
        loadFavorites()
    }
    
    func addObserver(_ observer: @escaping () -> Void) {
        observers.append(observer)
    }
    
    private func notifyObservers() {
        DispatchQueue.main.async {
            self.observers.forEach { $0() }
        }
    }
    
    // MARK: - API
    
    func fetchTrending() {
        APIManager.shared.fetchTrending(mediaType: .all) { [weak self] items in
            guard let self = self, let items = items else { return }
            
            // Mantém favoritos existentes
            let updatedItems = items.map { newItem -> TrendingItem in
                if let existing = self.items.first(where: { $0.id == newItem.id }) {
                    var mutable = newItem
                    mutable.isFavorite = existing.isFavorite
                    return mutable
                } else {
                    return newItem
                }
            }
            
            self.items = updatedItems
            self.loadFavorites()
            self.notifyObservers()
        }
    }
    
    func toggleFavorite(for item: TrendingItem) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].isFavorite.toggle()
        saveFavorites()
        notifyObservers()
    }
    
    // MARK: - Persistence
    
    private let favoritesKey = "favoritesKey"
    
    func saveFavorites() {
        let favoriteIDs = items.filter { $0.isFavorite }.map { $0.id }
        UserDefaults.standard.set(favoriteIDs, forKey: favoritesKey)
    }
    
    func loadFavorites() {
        guard let favoriteIDs = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] else { return }
        items = items.map { item in
            var mutable = item
            mutable.isFavorite = favoriteIDs.contains(item.id)
            return mutable
        }
    }
    
    var favoriteItems: [TrendingItem] {
        items.filter { $0.isFavorite }
    }
}
