//
//  NetworkError.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    
    case badURL
    case badJSON
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Bad URL"
        case .badJSON:
            return "Can't load data"
        case .notFound:
            return "Can't find city. Please check the name and try again"
        }
    }
}
