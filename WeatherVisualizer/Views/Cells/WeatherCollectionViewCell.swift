//
//  WeatherCollectionViewCell.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "WeatherCell"

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
