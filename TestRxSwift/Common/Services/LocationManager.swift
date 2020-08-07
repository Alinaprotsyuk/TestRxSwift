//
//  LocationManager.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

import CoreLocation
import RxSwift
import RxCocoa
import RxCoreLocation

class LocationManager {
    private let bag = DisposeBag()
    private let manager = CLLocationManager()
    
    let currentCoordinates: BehaviorRelay<CLLocation?> = BehaviorRelay(value: nil)
    
    init() {
        start()
    }
    
    private func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        manager.rx
            .didUpdateLocations
            .debug("didUpdateLocations")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .didChangeAuthorization
            .debug("didChangeAuthorization")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .placemark
            .debug("placemark")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .placemark
            .subscribe(onNext: { placemark in
                guard let name = placemark.name,
                    let isoCountryCode = placemark.isoCountryCode,
                    let country = placemark.country,
                    let postalCode = placemark.postalCode,
                    let locality = placemark.locality,
                    let subLocality = placemark.subLocality else {
                        return print("oops it looks like your placemark could not be computed")
                }
                print("name: \(name)")
                print("isoCountryCode: \(isoCountryCode)")
                print("country: \(country)")
                print("postalCode: \(postalCode)")
                print("locality: \(locality)")
                print("subLocality: \(subLocality)")
            })
            .disposed(by: bag)
        
        manager.rx
            .location
            .debug("location")
            .subscribe({ [weak self] (location) in
                guard let coordinates = location.element else { return }
                
                self?.currentCoordinates.accept(coordinates)
            })
            .disposed(by: bag)
        
        manager.rx
            .activityType
            .debug("activityType")
            .subscribe(onNext: {_ in})
            .disposed(by: bag)
        
        manager.rx
            .isEnabled
            .debug("isEnabled")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .didError
            .debug("didError")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .didDetermineState
            .debug("didDetermineState")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .didReceiveRegion
            .debug("didReceiveRegion")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
        
        manager.rx
            .didResume
            .debug("didResume")
            .subscribe(onNext: { _ in })
            .disposed(by: bag)
    }
}
