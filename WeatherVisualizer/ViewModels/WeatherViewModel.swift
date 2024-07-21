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
        WeatherType(nameKey: "Sunny", imageName: "sun.max"),
        WeatherType(nameKey: "Rain", imageName: "cloud.rain"),
        WeatherType(nameKey: "Thunderstorm", imageName: "cloud.bolt.rain"),
        WeatherType(nameKey: "Fog", imageName: "cloud.fog"),
        WeatherType(nameKey: "Snow", imageName: "cloud.snow")
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
