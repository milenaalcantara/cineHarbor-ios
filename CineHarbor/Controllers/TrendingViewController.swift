//
//  TrendingViewController.swift
//  CineHarbor
//
//  Created by Milena on 23/04/2025.
//

import UIKit

class TrendingViewController: UIViewController {
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
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Trending"
        view.backgroundColor = .theme.backgroundColor
        tabBarController?.tabBar.isTranslucent = false

        setupCollectionView()
        fetchTrending()
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
    
    private func fetchTrending() {
        APIManager.shared.fetchTrending(mediaType: .all) { [weak self] items in
            guard let self = self, let items = items else { return }
             
            DispatchQueue.main.async {
                self.items = items
                self.collectionView.reloadData()
            }
        }
    }
}

extension TrendingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrendingCell.identifier,
            for: indexPath
        ) as? TrendingCell else { return UICollectionViewCell() }
        cell.configure(with: items[indexPath.item])
        return cell
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.bounds.width - 48) / 2
        return CGSize(width: width, height: width * 1.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController(at: items[indexPath.item])
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
