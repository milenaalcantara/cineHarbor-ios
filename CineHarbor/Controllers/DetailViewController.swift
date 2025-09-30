//
//  DetailViewController.swift
//  CineHarbor
//
//  Created by Milena on 30/04/2025.
//

import UIKit

class DetailViewController: UIViewController {
    var item: TrendingItem
    private let detailView = DetailView()
    
    init(at item: TrendingItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.viewDidLoad()
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = item.title 
        view.backgroundColor = .theme.backgroundColor
        
        // Botão à direita
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,     // estilo
            target: self,      // quem vai receber a ação
            action: #selector(didTapFavorite) // função que será chamada
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
        
        // Configura a view com o item recebido
        detailView.configure(with: item)
    }
    
    @objc private func didTapFavorite() {
        item.isFavorite.toggle()
        if item.isFavorite {
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart.fill")
            return
        }
        navigationItem.rightBarButtonItem?.image = UIImage(systemName: "heart")
    }
}
