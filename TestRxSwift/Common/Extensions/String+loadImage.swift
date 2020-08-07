//
//  String+loadImage.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 07.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import UIKit

extension String {
    func loadImage() -> UIImage? {
        func makeURL(from string: String) -> URL? {
            return URL(string: "https://openweathermap.org/img/w/" + string + ".png")
        }
        
        guard let url = makeURL(from: self) else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        
        return UIImage(data: data)
    }
}
