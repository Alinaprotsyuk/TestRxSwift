//
//  FeelsLikeModel.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

struct FeelsLikeModel : Codable {
    let day: Double?
    let night: Double?
    let eve: Double?
    let morn: Double?

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case night = "night"
        case eve = "eve"
        case morn = "morn"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        day = try values.decodeIfPresent(Double.self, forKey: .day)
        night = try values.decodeIfPresent(Double.self, forKey: .night)
        eve = try values.decodeIfPresent(Double.self, forKey: .eve)
        morn = try values.decodeIfPresent(Double.self, forKey: .morn)
    }

}
