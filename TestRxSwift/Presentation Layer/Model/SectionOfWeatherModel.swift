//
//  SectionWeatherModel.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation
import RxDataSources

struct ConvertedTemperature {
    var key: String
    var temp: Double
}

struct SectionOfWeatherModel {
    var header: String
    var items: [ConvertedTemperature]
}

extension SectionOfWeatherModel: SectionModelType {
    typealias Item = ConvertedTemperature
    
    init(original: SectionOfWeatherModel, items: [ConvertedTemperature]) {
        self = original
        self.items = items
    }
}
