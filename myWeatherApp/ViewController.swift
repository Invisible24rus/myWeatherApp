//
//  ViewController.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
//    private let weatherSearchController = UISearchController(searchResultsController: nil)
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 50, right: 50)
        layout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .gray
        collectionView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: CityCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }


}

//MARK: - Private

private extension ViewController {
    
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

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return .zero }
        
        let itemsPerRow = 1
        let itemWidth = (collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right) / CGFloat(itemsPerRow)
        return CGSize(width: itemWidth, height: 200)
    }

}


//MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath)
        return cell
    }
    
}
