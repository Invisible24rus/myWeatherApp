//
//  ViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    private let networkService = NetworkService()
    private var emptyCity = WeatherResponce()
    private var citiesDefaultArray = ["Питер", "Абакан", "Москва"]
    private var cityResponceArray: [WeatherResponce] = []
    
//    private let weatherSearchController = UISearchController(searchResultsController: nil)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        getCityWeather()
        
    }
    
    func getCityWeather() {
        for city in citiesDefaultArray {
            featchWeaher(city: city)
        }
    }
    
    
    func featchWeaher(city: String) {
        networkService.fetchWeather(in: city) { [weak self] result in
            DispatchQueue.main.async  {
                guard let self = self else { return }
                switch result {
                case let .success(weatherResponce):
                    self.cityResponceArray.insert(weatherResponce, at: 0)
                case let .failure(error):
                    print(error)
                }
                print(result)
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func pressPlusButton() {
        alertAddCity(name: "", placeholder: "Введите город") { (city) in
            self.citiesDefaultArray.append(city)
            self.featchWeaher(city: city)
        }
    }
 
    
    
    
}







//MARK: - Private

private extension WeatherListViewController {
    
    func setupViews() {
        view.addSubview(collectionView)
        view.bindSubviewsToBoundsView(collectionView)
        
        title = "Список городов"
//        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24.0)]
        let addCityButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressPlusButton))
        navigationItem.rightBarButtonItem = addCityButton
        //        navigationItem.searchController = weatherSearchController
//        weatherSearchController.searchResultsUpdater = self
//        weatherSearchController.searchBar.placeholder = "Поиск города"
        

        
    }
}

//MARK: - UISearchResultsUpdating

//extension ViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else { return }
//
//        print(text)
//    }
//
//}

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
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(weatherMainViewController, animated: true)
//        weatherMainViewController.modalPresentationStyle = .fullScreen
//        present(weatherMainViewController, animated: true, completion: nil)
    }

}


//MARK: - UICollectionViewDataSource

extension WeatherListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cityResponceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as! CityCollectionViewCell
        
        let model = cityResponceArray[indexPath.row]
        cell.cellConfig(model: model)
        return cell
    }
    
}
