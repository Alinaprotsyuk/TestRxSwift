//
//  WeatherTableViewCell.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    func setup(weather model: WeatherList) {
        if let description = model.weather?.map({ $0.description ?? "" }).joined(separator: ", ") {
            descriptionLabel.text = description.capitalized
        }
        
        minTempLabel.text =  (model.temp?.min ?? 0).convertTempToString()
        maxTempLabel.text = (model.temp?.max ?? 0).convertTempToString()
        
        if let icon = model.weather?.first?.icon {
            iconImageView.image = icon.loadImage()
        }
    }
}
