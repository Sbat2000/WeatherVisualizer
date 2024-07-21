//
//  WeatherViewModel.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import Foundation

final class WeatherViewModel: WeatherViewModelProtocol {

    weak var delegate: WeatherViewModelDelegate?

    private(set) var weatherTypes: [WeatherType] = [
        WeatherType(nameKey: .sunny, imageName: Constants.WeatherImageNames.sunny),
        WeatherType(nameKey: .rain, imageName: Constants.WeatherImageNames.rain),
        WeatherType(nameKey: .thunderstorm, imageName: Constants.WeatherImageNames.thunderstorm),
        WeatherType(nameKey: .fog, imageName: Constants.WeatherImageNames.fog),
        WeatherType(nameKey: .snow, imageName: Constants.WeatherImageNames.snow)
    ]

    private(set) var selectedWeather: WeatherType? {
        didSet {
            delegate?.didUpdateWeather(self)
        }
    }

    private(set) var selectedIndex: Int?

    //MARK: - LifeCycle

    init() {
        selectRandomWeather()
    }

    //MARK: - Public methods

    func selectRandomWeather() {
        guard !weatherTypes.isEmpty else { return }
        selectedIndex = Int.random(in: 0..<weatherTypes.count)
    }

    func selectWeather(at index: Int) {
        selectedWeather = weatherTypes[index]
    }
}
