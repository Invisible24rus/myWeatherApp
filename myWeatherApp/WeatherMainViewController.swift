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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


//MARK: - Private

private extension WeatherMainViewController {
    
    func setupViews() {
        
        view.addSubviewsForAutoLayout([cityNameLabel,weatherInfoLabel,weatherTemperatureLabel, weatherHumidityLabel, weatherHumidityValueLabel])
        
        cityNameLabel.text = "Название"
        weatherInfoLabel.text = "Ясно"
        weatherTemperatureLabel.text = "33"
        weatherHumidityLabel.text = "Влажность"
        weatherHumidityValueLabel.text = "8"
        
        NSLayoutConstraint.activate([
            
            cityNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            cityNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherInfoLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherTemperatureLabel.topAnchor.constraint(equalTo: weatherInfoLabel.bottomAnchor, constant: 10),
            weatherTemperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherHumidityLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.bottomAnchor, constant: 50),
            weatherHumidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            weatherHumidityValueLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.bottomAnchor, constant: 50),
            weatherHumidityValueLabel.leadingAnchor.constraint(equalTo: weatherHumidityLabel.trailingAnchor, constant: 100)
            
            
        ])

        
    }
}
