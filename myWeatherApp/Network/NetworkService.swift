//
//  NetworkService.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation


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
                                    "lang": NSLocalizedString("weatherLanguage", comment: "")]
//        РУ МЕТРИК РУ, ЕН ИМПЕРИАЛ ЕН
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
    
    
    
    func fetchCityName(cityNameString: String, completion: @escaping (Result<[CityResponce], NetworkError>) -> Void) {
        
        let headers = [
            "x-rapidapi-host": "spott.p.rapidapi.com",
            "x-rapidapi-key": "6b85dd40fcmsha8ea181cba0213dp19a5d4jsnd6b2fd8ab9bb"
        ]
        
        let str = cityNameString
        let data = Data(str.utf8)
        let hexString = data.map{ String(format:"%02x", $0) }.joined(separator: "%")

        let request = NSMutableURLRequest(url: NSURL(string: "https://spott.p.rapidapi.com/places/autocomplete?limit=10&skip=0&language=%20ru&country=RU,US&q=%\(hexString)&type=CITY")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                      completion(.failure(.notFound))
                      return
                  }
            
            guard let data = data,
                  let jsonString = String(data: data, encoding: .utf8),
                  let model = try? JSONDecoder().decode([CityResponce].self, from: data) else {
                      completion(.failure(.badJSON))
                      return
                  }
            completion(.success(model))
        }.resume()
    }
}



