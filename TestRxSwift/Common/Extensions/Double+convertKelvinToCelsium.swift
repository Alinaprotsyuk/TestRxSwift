//
//  Double+convertKelvinToCelsium.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

extension Double {
    func convertKelvinToCelsium() -> Double {
        return self - 273.15
    }
}
