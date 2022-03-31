//
//  DecimalUtils.swift
//  Bankey
//
//  Created by 이서영 on 2022/03/27.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
