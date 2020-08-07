//
//  WeatherList.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

struct WeatherList: Codable {
    let dt: Int?
    let sunrise: Int?
    let sunset: Int?
    let temp: Temperature?
    let feelsLike: Temperature?
    let pressure: Int?
    let humidity: Int?
    let weather: [Weather]?
    let speed: Double?
    let deg: Int?
    let clouds: Int?
    let pop: Double?

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case sunrise = "sunrise"
        case sunset = "sunset"
        case temp = "temp"
        case feelsLike = "feels_like"
        case pressure = "pressure"
        case humidity = "humidity"
        case weather = "weather"
        case speed = "speed"
        case deg = "deg"
        case clouds = "clouds"
        case pop = "pop"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dt = try values.decodeIfPresent(Int.self, forKey: .dt)
        sunrise = try values.decodeIfPresent(Int.self, forKey: .sunrise)
        sunset = try values.decodeIfPresent(Int.self, forKey: .sunset)
        temp = try values.decodeIfPresent(Temperature.self, forKey: .temp)
        feelsLike = try values.decodeIfPresent(Temperature.self, forKey: .feelsLike)
        pressure = try values.decodeIfPresent(Int.self, forKey: .pressure)
        humidity = try values.decodeIfPresent(Int.self, forKey: .humidity)
        weather = try values.decodeIfPresent([Weather].self, forKey: .weather)
        speed = try values.decodeIfPresent(Double.self, forKey: .speed)
        deg = try values.decodeIfPresent(Int.self, forKey: .deg)
        clouds = try values.decodeIfPresent(Int.self, forKey: .clouds)
        pop = try values.decodeIfPresent(Double.self, forKey: .pop)
    }

}
