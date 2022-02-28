//
//  URL + Extensions.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation

extension URL {
    
    static func url(with path: String,
                    endpoint: String,
                    queryParams: JSONDict) -> URL? {
        guard let url = URL(string: path)?.appendingPathComponent(endpoint),
              var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0, value: "\($1)")}
        return urlComponents.url
    }
}
