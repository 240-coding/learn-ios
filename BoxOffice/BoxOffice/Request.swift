//
//  Request.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate
// MARK: - Notification Name
let DidReceiveMovieListNotification: Notification.Name = Notification.Name("DidReceiveMovieList")
let DidReceiveMovieInfoNotification: Notification.Name = Notification.Name("DidReceiveMovieInfoNotification")
// MARK: - Base URL
let baseUrl = "https://connect-boxoffice.run.goorm.io/"
// MARK: - Movie List
func requestMovieList() {
    let listUrl = "movies?order_type=" + appDelegate.listOrder
    guard let url: URL = URL(string: baseUrl + listUrl) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) {
        (data: Data?, response: URLResponse?, error: Error?) in
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else {
            return
        }
        do {
            let movieList: MovieListAPIResponse = try JSONDecoder().decode(MovieListAPIResponse.self, from: data)
            NotificationCenter.default.post(name: DidReceiveMovieListNotification, object: nil, userInfo: ["movieList":movieList.movies])
        } catch(let err) {
            print(String(describing: err))
        }
    }
    dataTask.resume()
}
// MARK: - Movie Info
func requestMovieInfo(_ id: String) {
    let movieUrl = "movie?id=" + id
    guard let url: URL = URL(string: baseUrl + movieUrl) else { return }
    
    let session: URLSession = URLSession(configuration: .default)
    let dataTask: URLSessionDataTask = session.dataTask(with: url) {
        (data: Data?, response: URLResponse?, error: Error?) in

        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let data = data else {
            return
        }
        do {
            let movieInfo: MovieInfo = try JSONDecoder().decode(MovieInfo.self, from: data)
            NotificationCenter.default.post(name: DidReceiveMovieInfoNotification, object: nil, userInfo: ["movieInfo":movieInfo])
        } catch(let err) {
            print(String(describing: err))
        }
    }
    dataTask.resume()
}
