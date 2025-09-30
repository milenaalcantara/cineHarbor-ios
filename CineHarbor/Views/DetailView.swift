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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.textColor = .systemGreen
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    } ()
    
    private lazy var overviewText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: TrendingItem) {
        APIManager.shared.loadImage(of: item, into: bannerImageView)
        titleLabel.text = item.title
        yearLabel.attributedText = labelFormatter(icon: "movieclapper.fill", and: dateFormatter(date: item.year), textColor: .white)
        ratingLabel.attributedText = labelFormatter(icon: "star.fill", and: String(item.voteAverage), textColor: .green)
        overviewText.text = item.overview
    }
    
    func dateFormatter(date: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        if let date = formatter.date(from: date) {
            let yearFormatter = DateFormatter()
            yearFormatter.dateFormat = "yyyy"
            let year = yearFormatter.string(from: date)
            return year
        }
        return ""
    }
    
    func labelFormatter(icon systemName: String, and text: String, textColor: UIColor) -> NSAttributedString {
        let image = UIImage(systemName: systemName)?
            .withTintColor(textColor, renderingMode: .alwaysOriginal)

        // Cria o attachment
        let attachment = NSTextAttachment()
        attachment.image = image

        // Ajusta automaticamente o tamanho da imagem para a fonte do label
        let font = UIFont.systemFont(ofSize: 10)
        attachment.bounds = CGRect(x: 0, y: (font.capHeight - font.lineHeight)/2, width: font.pointSize, height: font.pointSize)

        // Cria a string com o attachment
        let attachmentString = NSAttributedString(attachment: attachment)
        let ratingText = NSMutableAttributedString()
        ratingText.append(attachmentString)
        ratingText.append(NSAttributedString(string: " \(text)"))

        return ratingText
    }
}

extension DetailView: ViewCode {
    func setupHierarchy() {
        addSubview(bannerImageView)
        addSubview(titleLabel)
        addSubview(hStack)
        hStack.addArrangedSubview(yearLabel)
        hStack.addArrangedSubview(ratingLabel)
        addSubview(overviewText)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bannerImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bannerImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            bannerImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            
            titleLabel.topAnchor.constraint(equalTo: bannerImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            hStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            hStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            
            overviewText.topAnchor.constraint(equalTo: hStack.bottomAnchor, constant: 30),
            overviewText.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            overviewText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
        ])
    }
}
