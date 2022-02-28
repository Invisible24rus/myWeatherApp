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
        label.text = "Snow"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private var temperatueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "34°"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 64.0)
        return label
    }()
    
    private var cityInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "New York"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = contentView.frame.size.width / 10
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([weatherPropertiesLabel, temperatueInfoLabel, cityInfoLabel])
        
        NSLayoutConstraint.activate([
            weatherPropertiesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            weatherPropertiesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            temperatueInfoLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperatueInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            cityInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            cityInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20)
        ])
    }
    
}
