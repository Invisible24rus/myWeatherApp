//
//  WeatherType.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation

struct WeatherType: Decodable {
    let weatherProperty: String
    
    enum CodingKeys: String, CodingKey {
        case weatherProperty = "description"
    }
}
