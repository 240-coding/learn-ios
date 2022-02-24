//
//  Country.swift
//  WeatherToday
//
//  Created by 이서영 on 2022/01/25.
//

import Foundation

struct Country: Codable {
    var name: String
    var asset: String
    
    var imageName: String {
        return "flag_" + asset
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "korean_name"
        case asset = "asset_name"
    }
}
