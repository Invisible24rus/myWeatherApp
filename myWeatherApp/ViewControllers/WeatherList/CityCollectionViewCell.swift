//
//  CollectionViewCell.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 23.02.2022.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CityCollectionViewCell"
    
    private var weatherPropertiesLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("DEL", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(del), for: .touchUpInside)
        return button
    }()
    
    private var temperatueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 64.0)
        return label
    }()
    
    private var cityInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 22.0)
        return label
    }()
    
    private var actionHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = contentView.frame.size.width / 15
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    @objc func del(collectionView: UICollectionView, indexPath: IndexPath, array: [String]) {
//        var array = array
//        array.remove(at: indexPath.row)
//        collectionView.deleteItems(at: [indexPath])
//        collectionView.reloadData()
//    }
    
    
    
    func cellConfig(model: WeatherResponce, indexPath: IndexPath, actionHandler: @escaping () -> Void ) {
        temperatueInfoLabel.text = "\(Int(model.current.temp))°"
        cityInfoLabel.text = model.name?.firstUppercased
        if cityInfoLabel.text != "" {
            isUserInteractionEnabled = true
        }
        weatherPropertiesLabel.text = model.current.weather.first?.weatherDescription.firstUppercased
        
        self.actionHandler = actionHandler
    }
    
    @objc func del() {
        actionHandler?()
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([weatherPropertiesLabel, temperatueInfoLabel, cityInfoLabel, deleteButton])
        
        NSLayoutConstraint.activate([
            weatherPropertiesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            weatherPropertiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            temperatueInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperatueInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            cityInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            cityInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
}
