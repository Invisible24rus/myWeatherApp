//
//  CityNameTableViewCell.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 17.03.2022.
//

import UIKit

class CityNameTableViewCell: UITableViewCell {
    
    static let identifier = "CityNameTableViewCell"
    
    private let nameCityLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func cellConfig(model: CityResponce) {
        contentView.backgroundColor = .systemGray5
        nameCityLabel.text = model.localizedName.firstUppercased
    }
    
    func setConstraints() {
        contentView.addSubviewsForAutoLayout([nameCityLabel])
        
        NSLayoutConstraint.activate([
            nameCityLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            nameCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
        ])
    }

}
