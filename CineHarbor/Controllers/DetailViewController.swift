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
        view.backgroundColor = .theme.backgroundColor
    }
    
    

}
