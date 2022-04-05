//
//  ViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit
import CoreLocation
import MapKit

class WeatherListViewController: UIViewController {
    
    private let viewModel = WeatherListViewModel()
    private let networkService = NetworkService()
    private var emptyCity = WeatherResponce()
    private var citiesDefaultArray: [String] = UserDefaults.standard.stringArray(forKey: "citiesList") ?? [String]()
    private var cityResponceArray: [WeatherResponce] = []
    private var cityNameResponceArray: [[CityResponce]] = []
    private var isOffDelete = true
    
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
    
    @objc func pressPlusButton() {
        LocationManager.shared.getUserLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return }
                LocationManager.shared.getLocationName(with: location) { [weak self] locationName in
                    guard let cityName = locationName else { return }
                    print(cityName)
                    self?.getCityWeatherData(city: cityName, index: 0)
                }
                print(location.coordinate)
            }
        }
    }
    
    @objc func pressTrashButton() {
        isOffDelete = !isOffDelete
        collectionView.reloadData()
    }
    
    @objc func tap() {
        collectionView.endEditing(true)
    }
}

//MARK: - Private

private extension WeatherListViewController {
    
    func setupViews() {
        
        view.addSubviewsForAutoLayout([collectionView, tableViewCityName])
        
        view.bindSubviewsToBoundsView(collectionView)
        
        let getCurrentUserLocationButton = UIBarButtonItem(image: UIImage(systemName: "paperplane.fill"), style: .done, target: self, action: #selector(pressPlusButton))
        navigationItem.leftBarButtonItem = getCurrentUserLocationButton
        
        let getEditCitiesListButton = UIBarButtonItem(image: UIImage(systemName: "trash.circle.fill"), style: .done, target: self, action: #selector(pressTrashButton))
        navigationItem.rightBarButtonItem = getEditCitiesListButton
        
        
        
        cityResponceArray = Array(repeating: emptyCity, count: citiesDefaultArray.count)
        
        title = NSLocalizedString("titleWeatherList", comment: "")
        
        view.backgroundColor = .systemGray5
        
        tableViewCityName.backgroundColor = .systemGray5
        tableViewCityName.separatorStyle = .none
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0)]
        
        navigationItem.searchController = weatherSearchController
        navigationItem.backButtonTitle = ""
        
        weatherSearchController.searchResultsUpdater = self
        weatherSearchController.searchBar.placeholder = NSLocalizedString("searchBarTitle", comment: "")
        weatherSearchController.searchBar.setValue(NSLocalizedString("searchBarCancelButton", comment: ""), forKey: "cancelButtonText")
        
        NSLayoutConstraint.activate([
            tableViewCityName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewCityName.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewCityName.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewCityName.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

//MARK: - UISearchBarDelegate
extension WeatherListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableViewCityName.isHidden = searchText.isEmpty
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        tableViewCityName.isHidden = true
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
                        self.cityNameResponceArray = [responceCity]
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
        var itemHeight = itemWidth - 100
        if view.bounds.height < 600 {
            itemHeight = itemWidth
        }
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cityWeather = cityResponceArray[indexPath.row]
        let timeZone = cityResponceArray[indexPath.row].timezone
        let weatherMainViewController = WeatherMainViewController()
        weatherMainViewController.weatherModel = cityWeather
        weatherMainViewController.timeZone = timeZone
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
        cell.deleteButton.isHidden = isOffDelete
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
        
        if Locale.current.languageCode == "ru" {
            getCityWeatherData(city: city.localizedName, index: 0)
        } else {
            getCityWeatherData(city: city.name, index: 0)
        }
        
        tableViewCityName.isHidden = true
        weatherSearchController.isActive = false
    }
}

 
