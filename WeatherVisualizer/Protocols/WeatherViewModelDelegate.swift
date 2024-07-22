//
//  WeatherViewModelDelegate.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func didUpdateWeather(_ weather: WeatherType)
}
