//
//  ViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
//    private let weatherSearchController = UISearchController(searchResultsController: nil)
    private let collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }


}

//MARK: - Private

private extension ViewController {
    
    func setupViews() {
        
        
        
        view.addSubviewsForAutoLayout([])
        
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

//MARK: - UITableViewDataSource



//MARK: - UITableViewDelegate


