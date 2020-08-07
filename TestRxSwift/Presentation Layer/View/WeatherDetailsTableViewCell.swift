//
//  WeatherDetailsTableViewCell.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var mornTempLabal: UILabel!
    @IBOutlet weak var dayTempLabel: UILabel!
    @IBOutlet weak var eveTempLabel: UILabel!
    @IBOutlet weak var nightTempLabel: UILabel!
    
    func setup(data: Temperature) {
        if let minTemp = data.min {
            minTempLabel.text = "Min: \(minTemp.convertKelvinToCelsium().convertTempToString())"
        }
        if let maxTemp = data.max {
            maxTempLabel.text = "Max: \(maxTemp.convertKelvinToCelsium().convertTempToString())"
        }
        mornTempLabal.text = (data.morn ?? 300).convertKelvinToCelsium().convertTempToString()
        dayTempLabel.text = (data.day ?? 300).convertKelvinToCelsium().convertTempToString()
        eveTempLabel.text = (data.eve ?? 300).convertKelvinToCelsium().convertTempToString()
        nightTempLabel.text = (data.night ?? 300).convertKelvinToCelsium().convertTempToString()
    }
    
}
