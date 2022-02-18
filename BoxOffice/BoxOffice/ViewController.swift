//
//  ViewController.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import UIKit

class ViewController: UIViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    var movieList: [MovieList] = []
    let cellIdentifier = "movieListCell"
    
    // MARK: - View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationItemTitle()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieListNotification(_:)), name: DidReceiveMovieListNotification, object: nil)
        requestMovieList()

    }
    // MARK: - Set Navigation Item Title
    func setNavigationItemTitle() {
        switch self.appDelegate.listOrder {
        case "0":
            self.navigationItem.title = "예매율순"
        case "1":
            self.navigationItem.title = "큐레이션"
        default:
            self.navigationItem.title = "개봉일순"
        }
    }
    // MARK: - Notification Observer
    @objc func didReceiveMovieListNotification(_ noti: Notification) {
        guard let movieList: [MovieList] = noti.userInfo?["movieList"] as? [MovieList] else { return }
        
        self.movieList = movieList
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    // MARK: - Touch RightBarButtonItem
    @IBAction func touchUpRightBarButtonItem() {
        self.showAlertController(UIAlertController.Style.actionSheet)
    }
    
    func showAlertController(_ style: UIAlertController.Style) {
        let alertController: UIAlertController
        alertController = UIAlertController(title: "정렬 방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: style)
        // 예매율, 큐레이션, 개봉일
        let reservationRateAction: UIAlertAction
        reservationRateAction = UIAlertAction(title: "예매율", style: UIAlertAction.Style.default, handler: { _ in
            self.appDelegate.listOrder = "0"
            requestMovieList()
            self.navigationItem.title = "예매율순"
        })
        
        let curationAction: UIAlertAction
        curationAction = UIAlertAction(title: "큐레이션", style: UIAlertAction.Style.default, handler: { _ in
            self.appDelegate.listOrder = "1"
            requestMovieList()
            self.navigationItem.title = "큐레이션"
        })
        
        let dateAction: UIAlertAction
        dateAction = UIAlertAction(title: "개봉일", style: UIAlertAction.Style.default, handler: { _ in
            self.appDelegate.listOrder = "2"
            requestMovieList()
            self.navigationItem.title = "개봉일순"
        })
        
        let cancelAction: UIAlertAction
        cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(reservationRateAction)
        alertController.addAction(curationAction)
        alertController.addAction(dateAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? MovieListTableViewCell else { return }
        guard let nextViewController = segue.destination as? SecondViewController else { return }
        
        nextViewController.movieId = cell.id
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
        cell.id = movie.id
        
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

