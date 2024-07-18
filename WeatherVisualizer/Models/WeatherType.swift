//
//  WeatherType.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import Foundation

struct WeatherType {
    let nameKey: String
    let imageName: String

    var localizedName: String {
        return NSLocalizedString(nameKey, comment: "")
    }
}
