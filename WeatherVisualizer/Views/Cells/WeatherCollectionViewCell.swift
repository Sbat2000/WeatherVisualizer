//
//  WeatherCollectionViewCell.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "WeatherCell"

    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? UIColor.systemGray.withAlphaComponent(0.2) : UIColor.clear
                       contentView.layer.shadowOpacity = isSelected ? 0.5 : 0.3
        }
    }

    //MARK: - UI Elements

    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherLabel
    }()

    // MARK: - LifeCycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupLayer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods

    func configure(with weather: WeatherType) {
        weatherImageView.image = UIImage(systemName: weather.imageName)
        weatherLabel.text = weather.localizedName
    }

    // MARK: - Private methods

    private func setupLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.3
    }

    private func setupViews() {
        contentView.addSubview(weatherImageView)
        contentView.addSubview(weatherLabel)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 50),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),

            weatherLabel.topAnchor.constraint(equalTo: weatherImageView.bottomAnchor, constant: 8),
            weatherLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
