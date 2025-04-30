//
//  DetailView.swift
//  CineHarbor
//
//  Created by Milena on 30/04/2025.
//

import UIKit

class DetailView: UIView {

    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func configure(with item: TrendingItem) {
//        APIManager.shared.loadImage(of: item, into: bannerImageView)
//    }
}

extension DetailView: ViewCode {
    func setupHierarchy() {
        addSubview(bannerImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
        ])
    }
}
