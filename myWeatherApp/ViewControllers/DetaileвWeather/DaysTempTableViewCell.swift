//
//  DaysTempTableViewCell.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 14.03.2022.
//

import UIKit

class DaysTempTableViewCell: UITableViewCell {
    
    private let nameWeekDayLabel: UILabel = {
        let label = UILabel()
        label.text = "PON"
        label.textColor = .black
        return label
    }()
    private let dailyTemperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "15C"
        label.textColor = .black
        return label
    }()
    private let nightTemperature: UILabel = {
        let label = UILabel()
        label.text = "30C"
        label.textColor = .black
        return label
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    static let identifier = "DaysTempTableViewCell"

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
        dailyTemperatureLabel.text = "\(Int(model.temp.day))"
        nightTemperature.text = "\(Int(model.temp.night))"
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([nameWeekDayLabel, dailyTemperatureLabel, nightTemperature])
        
        NSLayoutConstraint.activate([
            nameWeekDayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameWeekDayLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dailyTemperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            dailyTemperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nightTemperature.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nightTemperature.trailingAnchor.constraint(equalTo: dailyTemperatureLabel.leadingAnchor, constant: -10),
        ])
    }
    
    

}
