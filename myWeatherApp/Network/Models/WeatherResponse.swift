//
//  WeatherResponse.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation

struct WeatherResponce: Decodable {
    let types: [WeatherType]
    let weather: Weather
    
    enum CodingKeys: String, CodingKey {
        case types = "weather"
        case weather = "main"
    }
 
}
