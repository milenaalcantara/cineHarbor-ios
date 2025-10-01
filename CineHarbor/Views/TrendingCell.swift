import UIKit

protocol TrendingCellDelegate: AnyObject {
    func trendingCellDidTapDetails(_ cell: TrendingCell)
    func trendingCellDidTapFavorite(_ cell: TrendingCell)
}

class TrendingCell: UICollectionViewCell {
    static let identifier = "TrendingCell"
    weak var delegate: TrendingCellDelegate?
    
    private let imageView = UIImageView()
    private let detailsButton = UIButton()
    private let favoriteButton = UIButton()
    private let hStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupConstraints()
        addTargets()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func setupHierarchy() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        detailsButton.setTitle("Ver Detalhes", for: .normal)
        detailsButton.titleLabel?.font = .systemFont(ofSize: 14)
        detailsButton.backgroundColor = .darkGray
        detailsButton.layer.cornerRadius = 8
        detailsButton.translatesAutoresizingMaskIntoConstraints = false
        
        favoriteButton.tintColor = .systemRed
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false

        hStack.axis = .horizontal
        hStack.distribution = .fillProportionally
        hStack.spacing = 16
        hStack.translatesAutoresizingMaskIntoConstraints = false
        
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
        setImageToFavoriteButton(item: item)
    }
    
    private func setImageToFavoriteButton(item: TrendingItem) {
        let imageName = item.isFavorite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    private func addTargets() {
        detailsButton.addTarget(self, action: #selector(didTapDetailsButton), for: .touchUpInside)
        favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
    }
    
    @objc private func didTapDetailsButton() {
        delegate?.trendingCellDidTapDetails(self)
    }
    
    @objc private func didTapFavoriteButton() {
        delegate?.trendingCellDidTapFavorite(self)
    }
}
