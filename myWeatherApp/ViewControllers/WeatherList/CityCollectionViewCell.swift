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
        label.numberOfLines = 2
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
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
        label.numberOfLines = 3
        label.sizeToFit()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
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
    
    func cellConfig(model: WeatherResponce, indexPath: IndexPath, actionHandler: @escaping () -> Void ) {
        temperatueInfoLabel.text = "\(Int(model.current.temp))°"
        cityInfoLabel.text = model.name?.firstUppercased
        if cityInfoLabel.text != "" {
            isUserInteractionEnabled = true
        }
        weatherPropertiesLabel.text = model.current.weather.first?.weatherDescription.firstUppercased
//        deleteButton.isHidden = true
        self.actionHandler = actionHandler
    }
    
    @objc func del() {
        actionHandler?()
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([weatherPropertiesLabel, temperatueInfoLabel, cityInfoLabel, deleteButton])
        
        NSLayoutConstraint.activate([
            
            weatherPropertiesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            weatherPropertiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherPropertiesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            temperatueInfoLabel.topAnchor.constraint(equalTo: weatherPropertiesLabel.bottomAnchor, constant: 10),
            temperatueInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            cityInfoLabel.topAnchor.constraint(equalTo: temperatueInfoLabel.bottomAnchor, constant: 10),
            cityInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cityInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -5),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 5),
            deleteButton.heightAnchor.constraint(equalToConstant: 20),
            deleteButton.widthAnchor.constraint(equalToConstant: 20),
        ])
    }
}
