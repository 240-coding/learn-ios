//
//  ViewController.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var movieList: [MovieList] = []
    let cellIdentifier = "movieListCell"
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestMovieList("0")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieListNotification(_:)), name: DidReceiveMovieListNotification, object: nil)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc func didReceiveMovieListNotification(_ noti: Notification) {
        guard let movieList: [MovieList] = noti.userInfo?["movieList"] as? [MovieList] else { return }
        
        self.movieList = movieList
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MovieListTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieListTableViewCell else { fatalError("셀 불러오기 실패") }
        let movie = self.movieList[indexPath.row]
        
        cell.poster.image = nil
        cell.title.text = movie.title
        cell.grade.image = UIImage(named: "ic_" + String(movie.grade))
        cell.userRating.text = String(movie.userRating)
        cell.reservationGrade.text = String(movie.reservationGrade)
        cell.reservationRate.text = String(movie.reservationRate)
        cell.date.text = movie.date
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                if let index: IndexPath = tableView.indexPath(for: cell) {
                    if index.row == indexPath.row {
                        cell.poster.image = UIImage(data: imageData)
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
}

