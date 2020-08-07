//
//  APIError.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String), wrongURL
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        case .wrongURL:
            return "Wrong URL address"
        }
    }
}
