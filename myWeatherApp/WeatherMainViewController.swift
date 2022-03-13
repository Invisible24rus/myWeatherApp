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
    private var cardWeatherView = UIView()

    private let weatherHumidityLabel = UILabel()
    private var weatherHumidityValueLabel = UILabel()
    
    var weatherModel: WeatherResponce?
    
    private var collectionViewTemp: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 15
        let collectionViewTemp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTemp.backgroundColor = .green
        collectionViewTemp.register(WeatherTempForecastCollectionViewCell.self, forCellWithReuseIdentifier: WeatherTempForecastCollectionViewCell.identifier)
        return collectionViewTemp
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupViews()
        collectionViewTemp.delegate = self
        collectionViewTemp.dataSource = self
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
        
        view.addSubviewsForAutoLayout([weatherHumidityLabel, weatherHumidityValueLabel, cardWeatherView, collectionViewTemp])
        cardWeatherView.addSubviewsForAutoLayout([cityNameLabel, weatherInfoLabel, weatherTemperatureLabel])
        
        cardWeatherView.backgroundColor = .white
        cardWeatherView.layer.cornerRadius = 25

        cityNameLabel.text = ""
        cityNameLabel.textColor = .black
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        weatherInfoLabel.text = ""
        weatherInfoLabel.textColor = .black
        weatherInfoLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        weatherTemperatureLabel.text = ""
        weatherTemperatureLabel.textColor = .black
        weatherTemperatureLabel.font = UIFont.boldSystemFont(ofSize: 64.0)
        
        weatherHumidityLabel.text = "Влажность"
        weatherHumidityLabel.textColor = .black
        weatherHumidityLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        weatherHumidityValueLabel.text = ""
        weatherHumidityValueLabel.textColor = .black
        weatherHumidityValueLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        
        NSLayoutConstraint.activate([
            
            collectionViewTemp.topAnchor.constraint(equalTo: weatherHumidityLabel.bottomAnchor, constant: 50),
            collectionViewTemp.heightAnchor.constraint(equalToConstant: 100),
            collectionViewTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionViewTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            cardWeatherView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            cardWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cardWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cardWeatherView.heightAnchor.constraint(equalToConstant: 300),
            
            cityNameLabel.topAnchor.constraint(equalTo: cardWeatherView.topAnchor, constant: 25),
            cityNameLabel.centerXAnchor.constraint(equalTo: cardWeatherView.centerXAnchor),
            
            weatherTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherTemperatureLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherInfoLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.bottomAnchor, constant: 10),
            weatherInfoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weatherHumidityLabel.topAnchor.constraint(equalTo: cardWeatherView.bottomAnchor, constant: 50),
            weatherHumidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            weatherHumidityValueLabel.topAnchor.constraint(equalTo: cardWeatherView.bottomAnchor, constant: 50),
            weatherHumidityValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)  
        ])

        
    }
}


extension WeatherMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let itemsPerRow = 5
        let itemWidth = (collectionView.frame.width - (layout.minimumLineSpacing * CGFloat(itemsPerRow-1))) / CGFloat(itemsPerRow)
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}


extension WeatherMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherTempForecastCollectionViewCell.identifier, for: indexPath) as! WeatherTempForecastCollectionViewCell
        return cell
    }
}
