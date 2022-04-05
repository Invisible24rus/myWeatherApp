//
//  DaysTempTableViewCell.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 14.03.2022.
//

import UIKit

class DaysTempTableViewCell: UITableViewCell {
    
    static let identifier = "DaysTempTableViewCell"
    
    private let nameWeekDayLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let dailyTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private let nightTemperature: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .systemGray
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    private let iconWeather: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.layer.cornerRadius = 10
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getDayFor(timestamp: Int) -> String {
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    func cellConfig(model: Daily) {
        let day = getDayFor(timestamp: model.dt)
        nameWeekDayLabel.text = "\(day.firstUppercased)"
        dailyTemperatureLabel.text = "\(Int(model.temp.day))°"
        nightTemperature.text = "\(Int(model.temp.night))°"
        guard let icon = model.weather.first?.getWeatherIcon() else { return }
        iconWeather.image = UIImage(systemName: icon)
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([nameWeekDayLabel, dailyTemperatureLabel, nightTemperature, iconWeather])
        
        NSLayoutConstraint.activate([
            nameWeekDayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameWeekDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dailyTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            dailyTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nightTemperature.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nightTemperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -60),
            
            iconWeather.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            iconWeather.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -100),
        ])
    }
}
