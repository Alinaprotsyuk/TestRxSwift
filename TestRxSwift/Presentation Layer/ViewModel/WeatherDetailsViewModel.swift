//
//  WeatherDetailsViewModel.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation
import RxSwift

class WeatherDetailsViewModel {
    var list: WeatherList
    var temperatureData = [[ConvertedTemperature]]()
    let bag = DisposeBag()
    
    init(list: WeatherList) {
        self.list = list
       
        if let temp = list.temp {
            let dict = temp.toDictionary()
            let firstRow = dict.map{ ConvertedTemperature(key: $0, temp: ($1 as? Double) ?? 0) }
            temperatureData.append(firstRow)
        }
        
        if let feelsLike = list.feelsLike {
            let dict = feelsLike.toDictionary()
            let secondRow = dict.map{ ConvertedTemperature(key: $0, temp: ($1 as? Double) ?? 0) }
            temperatureData.append(secondRow)
        }
    }
}
