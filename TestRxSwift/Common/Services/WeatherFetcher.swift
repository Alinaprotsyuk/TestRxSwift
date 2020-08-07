//
//  NetworkManager.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation
import RxSwift

struct OpenWeatherAPI {
        static let scheme = "https"
        static let host = "api.openweathermap.org"
        static let path = "/data/2.5"
        static let key = "1e838668ac1b0a52e51b5364dd4b82bd"
}

class WeatherFetcher {
    private let session: URLSession
    fileprivate lazy var jsonDecoder = JSONDecoder()
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    fileprivate func makeWeeklyForecastComponents(withCity city: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/forecast/daily"
        
        components.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "cnt", value: "7"),
            URLQueryItem(name: "APPID", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
    
    fileprivate func makeCurrentDayForecastComponentsFromCoordinates(lat: String, lon: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = OpenWeatherAPI.scheme
        components.host = OpenWeatherAPI.host
        components.path = OpenWeatherAPI.path + "/forecast/daily"
        
        components.queryItems = [
            URLQueryItem(name: "lat", value: lat),
            URLQueryItem(name: "lon", value: lon),
            URLQueryItem(name: "appid", value: OpenWeatherAPI.key)
        ]
        
        return components
    }
    
    fileprivate func makeRequest<T: Decodable>(request: URLRequest) -> Observable<T> {
        return Observable<T>.create { observer in
            let response = URLSession.shared.rx.response(request: request)
                .debug("test api request")
            
            return response.subscribe(onNext: { response, data in
                if 200..<300 ~= response.statusCode {
                    guard let responseItems = try? self.jsonDecoder.decode(T.self, from: data) else {
                        return observer.onError(APIError.unknown)
                    }
                    
                    observer.onNext(responseItems)
                    observer.onCompleted()
                } else {
                    observer.onError(APIError.apiError(reason: "Data is not available"))
                }
            }, onError: { error in
                observer.onError(APIError.apiError(reason: error.localizedDescription))
            }, onCompleted: nil,
               onDisposed: nil)
        }
    }
}

//MARK: - WeatherFetcherProtocol
extension WeatherFetcher: WeatherFetcherProtocol {
    func getWeatherByCoordinate(lat: String, lon: String) -> Observable<WeatherModel> {
        guard let fullURL = makeCurrentDayForecastComponentsFromCoordinates(lat: lat, lon: lon).url else {
            return Observable.error(APIError.wrongURL)
        }
        
        return makeRequest(request: URLRequest(url: fullURL)).asObservable()
    }
    
    func getWeatherByName(city: String) -> Observable<WeatherModel> {
        guard let fullURL = makeWeeklyForecastComponents(withCity: city).url else {
            return Observable.error(APIError.wrongURL)
        }
        
        return makeRequest(request: URLRequest(url: fullURL)).asObservable()
    }
}


