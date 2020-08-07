//
//  CurrentLocationViewModel.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class WeatherViewModel {
    private let locationManager: LocationManager
    private let networkManager: WeatherFetcherProtocol
    
    let bag = DisposeBag()
    var weatherList: BehaviorRelay<[WeatherList]> = BehaviorRelay(value: [WeatherList]())
    var error: BehaviorRelay<String?> = BehaviorRelay(value: nil)
    var city: City?
    var coordinates: CLLocationCoordinate2D?
    
    init(locationManager: LocationManager, networkManager: WeatherFetcher) {
        self.locationManager = locationManager
        self.networkManager = networkManager
        
        self.locationManager.currentCoordinates
            .subscribe(onNext: { [weak self] (location) in
                guard let coordinates = location?.coordinate else { return }
                self?.coordinates = coordinates
                self?.fetchWeather(by: coordinates)
            }, onError: { [weak self] (error) in
                self?.error.accept(error.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    private func fetchWeather(by coordinates: CLLocationCoordinate2D) {
        let lat = String(coordinates.latitude)
        let lon = String(coordinates.longitude)
        
        networkManager.getWeatherByCoordinate(lat: lat, lon: lon)
            .subscribe(onNext: { [weak self] (model) in
                guard let weatherList = model.list else { return }
                self?.weatherList.accept(weatherList)
                self?.city = model.city
                self?.error.accept(nil)
            }, onError: { [weak self] (error) in
                self?.error.accept(error.localizedDescription)
            }).disposed(by: bag)
    }
    
    func fetchWeatherFromCurrentLocation() {
        guard let coord = coordinates else { return }
        
        fetchWeather(by: coord)
    }
    
    func fetchWeatherByCity(name: String) {
        networkManager.getWeatherByName(city: name)
            .subscribe(onNext: { [weak self] (model) in
            guard let weatherList = model.list else { return }
            self?.weatherList.accept(weatherList)
            self?.city = model.city
            self?.error.accept(nil)
        }, onError: { [weak self] (error) in
            self?.error.accept(error.localizedDescription)
        }).disposed(by: bag)
    }
}
