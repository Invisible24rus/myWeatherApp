//
//  WeatherIcon.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 03.04.2022.
//

import Foundation

extension Weather {
    func getWeatherIcon() -> String {
        switch icon {
        case "01d":
            return "sun.max"
        case "01n":
            return "moon"
        case "02d":
            return "cloud.sun"
        case "02n":
            return "cloud.moon"
        case "03d":
            return "cloud"
        case "03n":
            return "cloud"
        case "04d":
            return "cloud"
        case "04n":
            return "cloud"
        case "09d":
            return "cloud.drizzle"
        case "09n":
            return "cloud.drizzle"
        case "10d":
            return "cloud.sun.rain"
        case "10n":
            return "cloud.moon.rain"
        case "11d":
            return "cloud.bolt"
        case "11n":
            return "cloud.bolt"
        case "13d":
            return "cloud.snow"
        case "13n":
            return "cloud.snow"
        case "50d":
            return "cloud.fog"
        case "50n":
            return "cloud.fog"
        default:
            return "sun.max"
        }
    }
}

