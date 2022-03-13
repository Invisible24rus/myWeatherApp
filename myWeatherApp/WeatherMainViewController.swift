//
//  WeatherMainViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import UIKit

class WeatherMainViewController: UIViewController {
    
    private var cityNameLabel = UILabel()
    private var weatherInfoLabel = UILabel()
    private var weatherTemperatureLabel = UILabel()

    private let weatherHumidityLabel = UILabel()
    private var weatherHumidityValueLabel = UILabel()
    
    var weatherModel: WeatherResponce?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupViews()
        reloadWeatherMainVC()
    }
    
    func reloadWeatherMainVC() {
        if let weatherModel = weatherModel {
            cityNameLabel.text = weatherModel.cityName
            weatherInfoLabel.text = weatherModel.types.first?.weatherProperty.capitalized
            weatherTemperatureLabel.text = "\(Int(weatherModel.weather.temperature))°"
            weatherHumidityValueLabel.text = "\(Int(weatherModel.weather.humidity))%"
        } else {
            return
        }
    }
}


//MARK: - Private

private extension WeatherMainViewController {
    
    func setupViews() {
        
        view.addSubviewsForAutoLayout([cityNameLabel,weatherInfoLabel,weatherTemperatureLabel, weatherHumidityLabel, weatherHumidityValueLabel])
        
        cityNameLabel.text = "XXXX"
        cityNameLabel.textColor = .black
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        weatherInfoLabel.text = "YASNO"
        weatherInfoLabel.textColor = .black
        weatherInfoLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        weatherTemperatureLabel.text = "55"
        weatherTemperatureLabel.textColor = .black
        weatherTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 64.0)
        
        weatherHumidityLabel.text = "Влажность"
        weatherHumidityLabel.textColor = .black
        weatherHumidityLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        weatherHumidityValueLabel.text = "6555"
        weatherHumidityValueLabel.textColor = .black
        weatherHumidityValueLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        
        NSLayoutConstraint.activate([
            
            cityNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherTemperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherInfoLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.bottomAnchor, constant: 10),
            weatherInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherHumidityLabel.topAnchor.constraint(equalTo: weatherInfoLabel.bottomAnchor, constant: 50),
            weatherHumidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            weatherHumidityValueLabel.topAnchor.constraint(equalTo: weatherInfoLabel.bottomAnchor, constant: 50),
            weatherHumidityValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            
            
        ])

        
    }
}
