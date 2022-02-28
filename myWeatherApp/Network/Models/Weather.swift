//
//  Weather.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation

struct Weather: Decodable {
    let temperature: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case humidity
    }
}
