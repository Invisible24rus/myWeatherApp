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
        label.text = "1"
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    private var temperatueInfoLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = .white
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getTimeFor(timestamp: Int) -> String {
        return timeFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    
    
    func cellConfig(model: Current) {
        let hour = getTimeFor(timestamp: model.dt)
        weatherTimeLabel.text = "\(hour)"
        temperatueInfoLabel.text = "\(Int(model.temp))°"
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
