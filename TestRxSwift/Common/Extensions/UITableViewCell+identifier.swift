//
//  UITableViewCell+identifier.swift
//  TestRxSwift
//
//  Created by Alina Protsyuk on 06.08.2020.
//  Copyright © 2020 AlinaProtsiukCompany. All rights reserved.
//

import UIKit

extension UITableViewCell {
    static var identifier: String {
        String(describing: self)
    }
}
