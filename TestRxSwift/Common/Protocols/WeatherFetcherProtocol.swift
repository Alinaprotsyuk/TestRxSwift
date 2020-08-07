//
//  WeatherFetcherProtocol.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation
import RxSwift

protocol WeatherFetcherProtocol {
    func getWeatherByCoordinate(lat: String, lon: String) -> Observable<WeatherModel>
    func getWeatherByName(city: String) -> Observable<WeatherModel>
}
