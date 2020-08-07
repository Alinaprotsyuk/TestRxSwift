//
//  String+convertTempToString.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

extension Double {
    func convertTempToString() -> String {
        return String(format: "%.1f", self.convertKelvinToCelsium()) + " Cº"
    }
}
