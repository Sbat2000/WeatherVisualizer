//
//  ViewController.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import UIKit

class WeatherViewController: UIViewController {

    //MARK: Private properties

    private var viewModel: WeatherViewModelProtocol?

    //MARK: - UI Elements

    private lazy var weatherCollectionView: UICollectionView = {
        let layout = createCompositionalLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    //MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupWeatherCollectionView()
        setupViews()
        setupConstraints()
        selectFirstWeather()
    }

    //MARK: - Private methods

    private func bindViewModel() {
        viewModel = WeatherViewModel()
        viewModel?.delegate = self
    }

    private func selectFirstWeather() {
        if let selectedIndex = viewModel?.selectedIndex {
            selectWeatherAndScrollToItem(at: selectedIndex)
        }
    }

    private func selectWeatherAndScrollToItem(at index: Int) {
        viewModel?.selectWeather(at: index)
        let indexPath = IndexPath(item: index, section: 0)
        weatherCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
        DispatchQueue.main.async {
            self.weatherCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }

    private func setupViews() {
        view.addSubview(weatherCollectionView)
    }

    private func setupWeatherCollectionView() {
        weatherCollectionView.backgroundColor = .clear
        weatherCollectionView.delegate = self
        weatherCollectionView.dataSource = self
        weatherCollectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier)
    }

    private func createCompositionalLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100),
                                               heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 10
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            weatherCollectionView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}

//MARK: - UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectWeatherAndScrollToItem(at: indexPath.row)
    }
}

//MARK: - UICollectionViewDataSource

extension WeatherViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.weatherTypes.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel else { return UICollectionViewCell() }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherCollectionViewCell.reuseIdentifier, for: indexPath) as! WeatherCollectionViewCell
        let weather = viewModel.weatherTypes[indexPath.item]
        cell.configure(with: weather)
        return cell
    }
}

//MARK: WeatherViewModelDelegate

extension WeatherViewController: WeatherViewModelDelegate {
    func didUpdateWeather(_ weather: WeatherType) {
        addAnimationLayer(for: weather.nameKey)
    }
}

//MARK: - Animation methods

private extension WeatherViewController {
    func addAnimationLayer(for nameKey: WeatherTypeName) {
        removePreviousAnimationLayer()

        let animationView: UIView?

        switch nameKey {
        case .snow:
            view.backgroundColor = .systemGray
            animationView = SnowView(frame: view.bounds)
        case .rain:
            view.backgroundColor = .systemGray
            animationView = RainView(frame: view.bounds)
        case .fog:
            view.backgroundColor = .systemGray
            animationView = FogView(frame: view.bounds)
        case .sunny:
            view.backgroundColor = .systemCyan
            animationView = SunnyView(frame: view.bounds)
        case .thunderstorm:
            view.backgroundColor = .systemGray
            animationView = ThunderstormView(frame: view.bounds)
        }

        if let animationView = animationView {
            animationView.isUserInteractionEnabled = false
            animationView.alpha = 0.0
            animationView.layer.name = Constants.weatherAnimationLayerName
            view.addSubview(animationView)

            UIView.animate(withDuration: 0.5) {
                animationView.alpha = 1.0
            }
        }
    }

    func removePreviousAnimationLayer() {
        let layersToRemove = view.subviews.filter { $0.layer.name == Constants.weatherAnimationLayerName }

        UIView.animate(withDuration: 0.5, animations: {
            layersToRemove.forEach { $0.alpha = 0.0 }
        }) { _ in
            layersToRemove.forEach { $0.removeFromSuperview() }
        }
    }
}
