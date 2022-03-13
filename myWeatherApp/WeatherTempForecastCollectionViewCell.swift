//
//  WeatherTempForecastCollectionViewCell.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 13.03.2022.
//

import UIKit

class WeatherTempForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "WeatherTempForecastCollectionViewCell"
    
    private var weatherTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "10:00"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private var temperatueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "34C"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([weatherTimeLabel, temperatueInfoLabel])
        
        NSLayoutConstraint.activate([
            weatherTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            weatherTimeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            temperatueInfoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            temperatueInfoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}
