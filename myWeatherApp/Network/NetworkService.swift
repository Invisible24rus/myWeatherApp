//
//  NetworkService.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation
import UIKit

typealias JSONDict = [String: Any]

class NetworkService {
    
    let baseURL = "https://api.openweathermap.org/data/2.5/"
    let apiKey = "ee2ee9b08d1a04076b75d0d38942f854"
    let method = "onecall"
    
    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherResponce, NetworkError>) -> Void) {
        
        let parameters: JSONDict = ["lat": latitude,
                                    "lon": longitude,
                                    "exclude": "minutely,alerts",
                                    "appid": apiKey,
                                    "units": "metric",
                                    "lang": "ru"]
        guard let url = URL.url(with: baseURL, endpoint: method, queryParams: parameters) else {
            completion(.failure(.badURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                      completion(.failure(.notFound))
                      return
                  }
            
            guard let data = data,
                  let jsonString = String(data: data, encoding: .utf8),
                  let model = try? JSONDecoder().decode(WeatherResponce.self, from: data) else {
                      completion(.failure(.badJSON))
                      return
                  }
//            print(jsonString)
//            print(url)
            completion(.success(model))
        }.resume()
    }
}
