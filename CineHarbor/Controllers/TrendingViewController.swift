//
//  TrendingViewController.swift
//  CineHarbor
//
//  Created by Milena on 23/04/2025.
//

import UIKit

class TrendingViewController: UIViewController {
    private let trendingView = TrendingView()
    
    override func loadView() {
        super.loadView()
        self.view = trendingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
