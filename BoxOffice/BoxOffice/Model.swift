//
//  Model.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import Foundation

// MARK: - MovieList
struct MovieListAPIResponse: Codable {
    let movies: [MovieList]
}

struct MovieList: Codable {
    var title: String
    var reservationRate: Double
    var id: String
    var thumb: String
    var date: String
    var grade: Int
    var reservationGrade: Int
    var userRating: Double
    
    var movieInfo: String {
        return "\(reservationGrade)위(\(userRating)) / \(reservationRate)%"
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case reservationRate = "reservation_rate"
        case id
        case thumb
        case date
        case grade
        case reservationGrade = "reservation_grade"
        case userRating = "user_rating"
    }
}
