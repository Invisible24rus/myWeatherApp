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
    let hourly: [Current]
    let daily: [Daily]
    
    init() {
        current = Current()
        hourly = [Current()]
        daily = [Daily()]
    }
}

struct Current: Decodable {
    let dt: Int
    let weather: [Weather]
    let humidity: Int
    let windSpeed: Double
    let temp: Double
    
    enum CodingKeys: String, CodingKey {
        case dt
        case weather
        case humidity
        case windSpeed = "wind_speed"
        case temp
       }
    
    init() {
        dt = 0
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

struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    
    init() {
        dt = 0
        temp = Temp(day: 0.0, night: 0.0)
    }
}

struct Temp: Decodable {
    var day: Double
    var night: Double
}
