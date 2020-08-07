//
//  WeatherModel.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let city: City?
    let cod: String?
    let message: Double?
    let cnt: Int?
    let list: [WeatherList]?

    enum CodingKeys: String, CodingKey {
        case city = "city"
        case cod = "cod"
        case message = "message"
        case cnt = "cnt"
        case list = "list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(City.self, forKey: .city)
        cod = try values.decodeIfPresent(String.self, forKey: .cod)
        message = try values.decodeIfPresent(Double.self, forKey: .message)
        cnt = try values.decodeIfPresent(Int.self, forKey: .cnt)
        list = try values.decodeIfPresent([WeatherList].self, forKey: .list)
    }
}
