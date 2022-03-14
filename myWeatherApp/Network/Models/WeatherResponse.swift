//
//  WeatherResponse.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation

struct WeatherResponce: Decodable {
    var name: String? = ""
    let current: Current
    
    init() {
        current = Current.init()
    }
}

struct Current: Decodable {
    let weather: [Weather]
    let humidity: Int
    let windSpeed: Double
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case weather
        case humidity
        case windSpeed = "wind_speed"
        case temp
       }
    
    init() {
        weather = [Weather(weatherDescription: "")]
        humidity = 0
        windSpeed = 0.0
        temp = 0.0
    }
}

struct Weather: Decodable {
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
       }
}


