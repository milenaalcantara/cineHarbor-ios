//
//  Untitled.swift
//  CineHarbor
//
//  Created by Milena on 23/04/2025.
//
import UIKit

protocol TrendingCellDelegate: AnyObject {
    func trendingCellDidTapDetails(_ cell: TrendingCell)
    func trendingCellDidTapFavorite(_ cell: TrendingCell)
}

class TrendingCell: UICollectionViewCell {
    static let identifier = "TrendingCell"
    weak var delegate: TrendingCellDelegate?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let detailsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ver Detalhes", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "detailsButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemRed
        button.accessibilityIdentifier = "favoriteButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    private let hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        addTargets()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierarchy() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        contentView.addSubview(hStack)
        hStack.addArrangedSubview(detailsButton)
        hStack.addArrangedSubview(favoriteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.85),
            
            hStack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            hStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            hStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            hStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }
    
    func configure(with item: TrendingItem) {
        APIManager.shared.loadImage(of: item, into: imageView)
    }
    
    func addTargets() {
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    @objc func didTapDetailsButton() {
        delegate?.trendingCellDidTapDetails(self)
    }
    
    @objc func didTapFavoriteButton() {
        delegate?.trendingCellDidTapFavorite(self)
    }
}
