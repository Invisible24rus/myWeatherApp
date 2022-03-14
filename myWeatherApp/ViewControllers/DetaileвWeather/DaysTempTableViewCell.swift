//
//  DaysTempTableViewCell.swift
//  myWeatherApp
//
//  Created by NIKITA NIKOLICH on 14.03.2022.
//

import UIKit

class DaysTempTableViewCell: UITableViewCell {
    
    static let identifier = "DaysTempTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
