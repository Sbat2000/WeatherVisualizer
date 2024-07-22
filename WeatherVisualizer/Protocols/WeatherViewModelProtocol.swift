//
//  WeatherViewModelProtocol.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import Foundation

protocol WeatherViewModelProtocol {
    var delegate: WeatherViewModelDelegate? { get set }
    var weatherTypes: [WeatherType] { get }
    var selectedWeather: WeatherType? { get }
    var selectedIndex: Int? { get }

    func selectWeather(at index: Int)
}
