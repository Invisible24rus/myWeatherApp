//
//  WeatherMainViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 27.02.2022.
//

import UIKit

class WeatherMainViewController: UIViewController {
    
    
    var weatherModel: WeatherResponce?
    var timeZone: String?
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return formatter
    }()

    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var cardWeatherView = UIView()
    
    private var cityNameLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private var weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .gray
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private var weatherTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 64.0)
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private let weatherHumidityLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("humidity", comment: "")
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()

    private var weatherHumidityValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textColor = .systemBlue
        return label
    }()

    private var windSpeedLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("windSpeed", comment: "")
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textColor = .black
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private var windSpeedValueLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textColor = .black
        return label
    }()

    private var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        label.textColor = .systemBlue
        return label
    }()
    
    private let collectionViewWeatherHourlyTemp: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
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
        tableView.isUserInteractionEnabled = false
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
        tableViewWeatherDaysTemp.delegate = self
        tableViewWeatherDaysTemp.dataSource = self
        reloadWeatherMainVC()
        
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func reloadWeatherMainVC() {
        if let weatherModel = weatherModel {
            guard let timeZone = timeZone else { return }
            timeFormatter.timeZone = TimeZone(identifier: "\(timeZone)")
            let time = getTimeFor(timestamp: weatherModel.current.dt)
            cityNameLabel.text = weatherModel.name?.firstUppercased
            weatherTemperatureLabel.text = "\(Int(weatherModel.current.temp))°"
            weatherInfoLabel.text = weatherModel.current.weather.first?.weatherDescription.firstUppercased
            currentTimeLabel.text = "\(time)"
            weatherHumidityValueLabel.text = "\(Int(weatherModel.current.humidity))%"
            windSpeedValueLabel.text = "\(Int(weatherModel.current.windSpeed)) \(NSLocalizedString("metersPerSecond", comment: ""))"
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
        cardWeatherView.addSubviewsForAutoLayout([cityNameLabel, weatherInfoLabel, weatherTemperatureLabel, currentTimeLabel])
        
        title = NSLocalizedString("details", comment: "")
        
        contentView.backgroundColor = .systemGray5
        view.backgroundColor = .systemGray5
        scrollView.backgroundColor = .systemGray5
        scrollView.bounces = true
        
        cardWeatherView.backgroundColor = .white
        cardWeatherView.layer.cornerRadius = 25

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
            tableViewWeatherDaysTemp.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            
            cardWeatherView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            cardWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            cardWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            cardWeatherView.bottomAnchor.constraint(equalTo: currentTimeLabel.bottomAnchor, constant: 20),
            
            cityNameLabel.topAnchor.constraint(equalTo: cardWeatherView.topAnchor, constant: 20),
            cityNameLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            cityNameLabel.trailingAnchor.constraint(equalTo: cardWeatherView.trailingAnchor, constant: -20),
            
            weatherTemperatureLabel.topAnchor.constraint(equalTo: cityNameLabel.bottomAnchor, constant: 20),
            weatherTemperatureLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            
            weatherInfoLabel.topAnchor.constraint(equalTo: weatherTemperatureLabel.bottomAnchor, constant: 20),
            weatherInfoLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            weatherInfoLabel.trailingAnchor.constraint(equalTo: cardWeatherView.trailingAnchor, constant: -20),
            
            currentTimeLabel.topAnchor.constraint(equalTo: weatherInfoLabel.bottomAnchor, constant: 20),
            currentTimeLabel.leadingAnchor.constraint(equalTo: cardWeatherView.leadingAnchor, constant: 20),
            
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
        if let model = weatherModel?.hourly[indexPath.row], let timeZone = timeZone {
            cell.cellConfig(model: model, timeZone: timeZone)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension WeatherMainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
}

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
