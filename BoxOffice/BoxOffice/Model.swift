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
// MARK: - Movie Info
struct MovieInfo: Codable {
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case audience
        case actor
        case duration
        case director
        case synopsis
        case genre
        case grade
        case image
        case reservationGrade = "reservation_grade"
        case title
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
        case date
        case id
    }
}
// MARK: - Comments
struct CommentsAPIResponse: Codable {
    let comments: [Comments]
}
struct Comments: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case rating
        case timestamp
        case writer
        case movieId = "movie_id"
        case contents
        case id
    }
}
// MARK: - User Comment
struct UserComment: Codable {
    var rating: Double?
    var writer: String?
    var movieId: String?
    var contents: String?
    
    enum CodingKeys: String, CodingKey {
        case rating
        case writer
        case movieId = "movie_id"
        case contents
    }
}
