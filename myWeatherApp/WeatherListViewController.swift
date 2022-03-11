//
//  ViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    private let networkService = NetworkService()
    private let citiesDefaultArray = ["Москва", "Питер"]
    private let city = "Абакан"
    private var ar: [WeatherResponce] = []
    
//    private let weatherSearchController = UISearchController(searchResultsController: nil)
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 50, right: 50)
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
        
        for city in citiesDefaultArray {
            networkService.fetchWeather(in: city) { (WeatherResponce) in
                switch WeatherResponce {
                    
                case .success(let test):
                    self.ar.append(test)
                    print(test)
                case .failure(let test2):
                    print(test2)
                }
//                print(WeatherResponce)
                
                
            }
        }
//        print(ar)
        
//        networkService.fetchWeather(in: "Москва") { (WeatherResponce) in
//            print(WeatherResponce)
//        }
        
    }

}

//MARK: - Private

private extension WeatherListViewController {
    
    func setupViews() {
        view.addSubview(collectionView)
        view.bindSubviewsToBoundsView(collectionView)
//        title = "Список городов"
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

}


//MARK: - UICollectionViewDataSource

extension WeatherListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        citiesDefaultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
}
