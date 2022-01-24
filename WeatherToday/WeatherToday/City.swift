//
//  City.swift
//  WeatherToday
//
//  Created by 이서영 on 2022/01/25.
//

import Foundation

struct City: Codable {
    var name: String
    var state: Int
    var celsius: Float
    var rainfallProbability: Int
    var fahrenheit: Float {
        return celsius * 1.8 + 32
    }
    var weatherImage: String {
        switch state {
        case 10:
            return "sunny"
        case 11:
            return "cloudy"
        case 12:
            return "rainy"
        case 13:
            return "snowy"
        default:
            return "sunny"
        }
    }
    var degreeText: String {
        return "섭씨 \(celsius)도 / 화씨 \(String(format: "%.1f", fahrenheit))도"
    }
    var rainfallText: String {
        return "강수확률 \(rainfallProbability)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "city_name"
        case state, celsius
        case rainfallProbability = "rainfall_probability"
    }
}
