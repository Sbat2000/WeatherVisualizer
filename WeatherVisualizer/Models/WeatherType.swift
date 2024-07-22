//
//  WeatherType.swift
//  WeatherVisualizer
//
//  Created by Aleksandr Garipov on 18.07.2024.
//

import Foundation

enum WeatherTypeName: String {
    case sunny
    case rain
    case thunderstorm
    case fog
    case snow
}


struct WeatherType {
    let nameKey: WeatherTypeName
    let imageName: String

    var localizedName: String {
        return NSLocalizedString(nameKey.rawValue.capitalized, comment: "")
    }
}
