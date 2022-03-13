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
    let cityName: String
    
    enum CodingKeys: String, CodingKey {
        case types = "weather"
        case weather = "main"
        case cityName = "name"
    }
    
    init() {
        types = [WeatherType(weatherProperty: "")]
        weather = Weather(temperature: 0.0, humidity: 0)
        cityName = ""
    }
 
}
