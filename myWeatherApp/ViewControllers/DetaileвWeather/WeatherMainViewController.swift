//
//  WeatherMainViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import UIKit

class WeatherMainViewController: UIViewController {
    
    
    var weatherModel: WeatherResponce?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private var cityNameLabel = UILabel()
    private var weatherInfoLabel = UILabel()
    private var weatherTemperatureLabel = UILabel()
    private var cardWeatherView = UIView()
    private let weatherHumidityLabel = UILabel()
    private var weatherHumidityValueLabel = UILabel()
    private var windSpeedLabel = UILabel()
    private var windSpeedValueLabel = UILabel()
    private var welcomeLabel = UILabel()
    
    private let collectionViewWeatherHourlyTemp: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 15
        let collectionViewTemp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewTemp.backgroundColor = .white
        collectionViewTemp.layer.cornerRadius = 15
        collectionViewTemp.showsHorizontalScrollIndicator = false
        collectionViewTemp.register(WeatherTempForecastCollectionViewCell.self, forCellWithReuseIdentifier: WeatherTempForecastCollectionViewCell.identifier)
        return collectionViewTemp
    }()
    
    private let tableViewWeatherDaysTemp: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.layer.cornerRadius = 15
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DaysTempTableViewCell.self, forCellReuseIdentifier: DaysTempTableViewCell.identifier)
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.collectionViewWeatherHourlyTemp.reloadData()
        collectionViewWeatherHourlyTemp.delegate = self
        collectionViewWeatherHourlyTemp.dataSource = self
//        tableViewWeatherDaysTemp.delegate = self
        tableViewWeatherDaysTemp.dataSource = self
        reloadWeatherMainVC()
        
    }
    
    func reloadWeatherMainVC() {
        
        if let weatherModel = weatherModel {
            cityNameLabel.text = weatherModel.name?.firstUppercased
            weatherInfoLabel.text = weatherModel.current.weather.first?.weatherDescription.firstUppercased
            weatherTemperatureLabel.text = "\(Int(weatherModel.current.temp))°"
            welcomeLabel.text = "Welcome Buddy"
            weatherHumidityValueLabel.text = "\(Int(weatherModel.current.humidity))%"
            windSpeedValueLabel.text = "\(Int(weatherModel.current.windSpeed)) м/с"
        } else {
            return
        }
    }
}


//MARK: - Private

private extension WeatherMainViewController {
    
    func setupViews() {
        
        view.addSubviewsForAutoLayout(scrollView)
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviewsForAutoLayout([weatherHumidityLabel, weatherHumidityValueLabel, cardWeatherView, collectionViewWeatherHourlyTemp, windSpeedLabel, windSpeedValueLabel, tableViewWeatherDaysTemp])
        cardWeatherView.addSubviewsForAutoLayout([cityNameLabel, weatherInfoLabel, weatherTemperatureLabel, welcomeLabel])
        
        
        
        contentView.backgroundColor = .systemGray5
        view.backgroundColor = .systemGray5
        scrollView.backgroundColor = .systemGray5
        scrollView.bounces = true
        
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
        
        windSpeedLabel.text = "Скорость ветра"
        windSpeedLabel.textColor = .black
        windSpeedLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        windSpeedValueLabel.text = ""
        windSpeedValueLabel.textColor = .black
        windSpeedValueLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        welcomeLabel.text = "XXX"
        welcomeLabel.textColor = .systemBlue
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 24.0)
        
        
        NSLayoutConstraint.activate([
            
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            collectionViewWeatherHourlyTemp.topAnchor.constraint(equalTo: windSpeedLabel.bottomAnchor, constant: 50),
            collectionViewWeatherHourlyTemp.heightAnchor.constraint(equalToConstant: 100),
            collectionViewWeatherHourlyTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionViewWeatherHourlyTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            tableViewWeatherDaysTemp.topAnchor.constraint(equalTo: collectionViewWeatherHourlyTemp.bottomAnchor, constant: 50),
            tableViewWeatherDaysTemp.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableViewWeatherDaysTemp.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableViewWeatherDaysTemp.heightAnchor.constraint(equalToConstant: 300),
            tableViewWeatherDaysTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -0),
            
            
            cardWeatherView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            cardWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cardWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cardWeatherView.heightAnchor.constraint(equalToConstant: 300),
            
            cityNameLabel.topAnchor.constraint(equalTo: cardWeatherView.topAnchor, constant: 25),
            cityNameLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            
            weatherTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherTemperatureLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            
            weatherInfoLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.bottomAnchor, constant: 10),
            weatherInfoLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            
            welcomeLabel.topAnchor.constraint(equalTo: weatherInfoLabel.bottomAnchor, constant: 10),
            welcomeLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            
            weatherHumidityLabel.topAnchor.constraint(equalTo: cardWeatherView.bottomAnchor, constant: 50),
            weatherHumidityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            weatherHumidityValueLabel.topAnchor.constraint(equalTo: cardWeatherView.bottomAnchor, constant: 50),
            weatherHumidityValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            windSpeedLabel.topAnchor.constraint(equalTo: weatherHumidityValueLabel.bottomAnchor, constant: 20),
            windSpeedLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            windSpeedValueLabel.topAnchor.constraint(equalTo: weatherHumidityValueLabel.bottomAnchor, constant: 20),
            windSpeedValueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])

        
    }
}

//MARK: - UICollectionViewDelegate
extension WeatherMainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let itemsPerRow = 5
        let itemWidth = (collectionView.frame.width - (layout.minimumLineSpacing * CGFloat(itemsPerRow-1))) / CGFloat(itemsPerRow)
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}

//MARK: - UICollectionViewDataSource
extension WeatherMainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeatherTempForecastCollectionViewCell.identifier, for: indexPath) as! WeatherTempForecastCollectionViewCell
        if let model = weatherModel?.hourly[indexPath.row] {
            cell.cellConfig(model: model)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate




//MARK: - UITableViewDataSource
extension WeatherMainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DaysTempTableViewCell.identifier, for: indexPath) as! DaysTempTableViewCell
    
    if let model = weatherModel?.daily[indexPath.row] {
        cell.cellConfig(model: model)
    }
    return cell
    
    }
}
