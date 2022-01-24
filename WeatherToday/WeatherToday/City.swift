//
//  City.swift
//  WeatherToday
//
//  Created by 이서영 on 2022/01/25.
//

import Foundation

//{
//   "city_name":"파리",
//   "state":10,
//   "celsius":11.3,
//   "rainfall_probability":90
//},
//
//10 : sunny
//11 : cloudy
//12 : rainy
//13 : snowy

struct City {
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
        return "섭씨 \(celsius)도 / 화씨 \(fahrenheit)도"
    }
    var rainfallText: String {
        return "강수확률 \(rainfallProbability)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case name, state, celsius
        case rainfallProbability = "rainfall_probability"
    }
}
