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
    let timezone: String
    
    init() {
        current = Current()
        hourly = [Current()]
        daily = [Daily()]
        timezone = ""
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
        weather = [Weather(weatherDescription: "", icon: "01d")]
        humidity = 0
        windSpeed = 0.0
        temp = 0.0
    }
}

struct Daily: Decodable {
    let dt: Int
    let temp: Temp
    let weather: [Weather]
    
    init() {
        dt = 0
        temp = Temp(day: 0.0, night: 0.0)
        weather = [Weather(weatherDescription: "", icon: "01d")]
    }
}

struct Temp: Decodable {
    var day: Double
    var night: Double
}


struct Weather: Decodable {
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}

