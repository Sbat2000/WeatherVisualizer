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
        view.backgroundColor = .systemCyan
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
            let indexPath = IndexPath(item: selectedIndex, section: 0)
            weatherCollectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
            viewModel?.selectWeather(at: indexPath.row)
            DispatchQueue.main.async {
                self.weatherCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
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

//MARK: UICollectionViewDelegate

extension WeatherViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.selectWeather(at: indexPath.row)
    }
}

//MARK: UICollectionViewDataSource

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
    func didUpdateWeather(_ viewModel: WeatherViewModelProtocol) {
        guard let selectedWeather = viewModel.selectedWeather else { return }
        print(selectedWeather.localizedName)
    }
}
