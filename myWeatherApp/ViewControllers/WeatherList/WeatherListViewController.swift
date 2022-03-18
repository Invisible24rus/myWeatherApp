//
//  ViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit
import CoreLocation

class WeatherListViewController: UIViewController {
    
    private let networkService = NetworkService()
    private var emptyCity = WeatherResponce()
    private var citiesDefaultArray: [String] = UserDefaults.standard.stringArray(forKey: "citiesList") ?? [String]()
    private var cityResponceArray: [WeatherResponce] = []
    private var cityNameResponceArray: [[CityResponce]] = []
    
    private let weatherSearchController = UISearchController(searchResultsController: nil)
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 25, left: 50, bottom: 50, right: 50)
        layout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray5
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        return collectionView
    }()
    
    private let tableViewCityName: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.register(CityNameTableViewCell.self, forCellReuseIdentifier: CityNameTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        tableViewCityName.dataSource = self
        tableViewCityName.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        weatherSearchController.searchBar.delegate = self
        getCityWeatherCell()
        
    }
    
    func stringToHex(string: String) -> String {
        let data = Data(string.utf8)
        let hexString = data.map{ String(format:"%02x", $0) }.joined(separator: "%")
        return hexString
    }
    
    func getCityWeatherCell() {
        for (index, city) in citiesDefaultArray.enumerated() {
            getCoordinateFrom(city: city) { coordinate, error in
                guard let coordinate = coordinate, error == nil else { return }
                
                self.networkService.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] result in
                    DispatchQueue.main.async  {
                        guard let self = self else { return }
                        switch result {
                        case let .success(weatherResponce):
                            self.cityResponceArray[index] = weatherResponce
                            self.cityResponceArray[index].name = self.citiesDefaultArray[index]
                            print(weatherResponce.daily)
                        case let .failure(error):
                            print(error)
                        }
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }
    
   
    
    func getCityWeatherData(city: String, index: Int) {

        getCoordinateFrom(city: city) { coordinate, error in
            guard let coordinate = coordinate, error == nil else { return }
            
            self.networkService.fetchWeather(latitude: coordinate.latitude, longitude: coordinate.longitude) { [weak self] result in
                DispatchQueue.main.async  {
                    guard let self = self else { return }
                    switch result {
                    case let .success(weatherResponce):
                        self.citiesDefaultArray.insert(city, at: 0)
                        UserDefaults.standard.set(self.citiesDefaultArray, forKey: "citiesList")
                        self.cityResponceArray.insert(self.emptyCity, at: 0)
                        self.cityResponceArray[index] = weatherResponce
                        self.cityResponceArray[index].name = self.citiesDefaultArray[index]
                    case let .failure(error):
                        print(error)
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

//MARK: - Private

private extension WeatherListViewController {
    
    func setupViews() {
        
        view.addSubviewsForAutoLayout([collectionView, tableViewCityName])
        
        view.bindSubviewsToBoundsView(collectionView)
        
        cityResponceArray = Array(repeating: emptyCity, count: citiesDefaultArray.count)
        
        title = "Список городов"
        
        view.backgroundColor = .systemGray5
        
        tableViewCityName.backgroundColor = .systemGray5
        tableViewCityName.separatorStyle = .none
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0)]
//        let addCityButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressPlusButton))
//        navigationItem.rightBarButtonItem = addCityButton
        
        navigationItem.searchController = weatherSearchController
        navigationItem.backButtonTitle = ""
        
        weatherSearchController.searchResultsUpdater = self
        weatherSearchController.searchBar.placeholder = "Поиск города"
        weatherSearchController.searchBar.setValue("Отмена", forKey: "cancelButtonText")
        
        NSLayoutConstraint.activate([
            tableViewCityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableViewCityName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableViewCityName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -0),
            tableViewCityName.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -0),
        ])
    }
}

//MARK: - UISearchBarDelegate
extension WeatherListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            tableViewCityName.isHidden = true
        } else {
            tableViewCityName.isHidden = false
        }
    }
}


//MARK: - UISearchResultsUpdating

extension WeatherListViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if text == "" {
            return
        } else {
            networkService.fetchCityName(cityNameString: text) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case let .success(responceCity):
                        self.cityNameResponceArray = []
                        self.cityNameResponceArray.append(responceCity)
                        self.tableViewCityName.reloadData()
                    case let .failure(error):
                        print(error)
                    }
                }
                
            }
        }
    }
}

//MARK: - UICollectionViewDelegate

extension WeatherListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let itemsPerRow = 1
        let itemWidth = (collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right) / CGFloat(itemsPerRow)
        let itemHeight = itemWidth - 100
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cityWeather = cityResponceArray[indexPath.row]
        let weatherMainViewController = WeatherMainViewController()
        weatherMainViewController.weatherModel = cityWeather
        
        navigationController?.pushViewController(weatherMainViewController, animated: true)
    }
}

extension WeatherListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityResponceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        let model = cityResponceArray[indexPath.row]
        cell.cellConfig(model: model, indexPath: indexPath) { [weak self, weak cell] in
                    guard let self = self,
                          let cell = cell,
                          let indexPath = self.collectionView.indexPath(for: cell) else { return }
                    self.cityResponceArray.remove(at: indexPath.row)
                    self.citiesDefaultArray.remove(at: indexPath.row)
            UserDefaults.standard.set(self.citiesDefaultArray, forKey: "citiesList")
                    self.collectionView.deleteItems(at: [indexPath])
                }
       
                return cell
            }
}

//MARK: - UITableViewDataSource
extension WeatherListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityNameResponceArray.first?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CityNameTableViewCell.identifier, for: indexPath) as! CityNameTableViewCell
        if let model = cityNameResponceArray.first?[indexPath.row] {
            cell.cellConfig(model: model)
        }
        return cell
        
    }
}

extension WeatherListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = (cityNameResponceArray.first?[indexPath.row]) else { return }
        getCityWeatherData(city: city.localizedName, index: 0)
        tableViewCityName.isHidden = true
        weatherSearchController.isActive = false
    }
}
