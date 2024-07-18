//
//  WeatherViewModel.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import Foundation

final class WeatherViewModel {

    private(set) var weatherTypes: [WeatherType] = [
        WeatherType(nameKey: "Sunny", imageName: "sun.max"),
        WeatherType(nameKey: "Rain", imageName: "cloud.rain"),
        WeatherType(nameKey: "Thunderstorm", imageName: "cloud.bolt.rain"),
        WeatherType(nameKey: "Fog", imageName: "cloud.fog"),
        WeatherType(nameKey: "Snow", imageName: "cloud.snow")
    ]
}
