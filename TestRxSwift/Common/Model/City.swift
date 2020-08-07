//
//  City.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

struct City: Codable {
    let id: Int?
    let name: String?
    let country: String?
    let population: Int?
    let timezone: Int?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case country = "country"
        case population = "population"
        case timezone = "timezone"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        country = try values.decodeIfPresent(String.self, forKey: .country)
        population = try values.decodeIfPresent(Int.self, forKey: .population)
        timezone = try values.decodeIfPresent(Int.self, forKey: .timezone)
    }

}
