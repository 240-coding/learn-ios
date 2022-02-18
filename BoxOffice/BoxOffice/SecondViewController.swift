//
//  TableSecondViewController.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/17.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var movieId: String?
    var movieInfo: MovieInfo?
    var firstCellIdentifier = "firstInfoCell"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieInfoNotification(_:)), name: DidReceiveMovieInfoNotification, object: nil)
        if let movieId = movieId {
            requestMovieInfo(movieId)
        }
    }
    // MARK: - Notification Observer
    @objc func didReceiveMovieInfoNotification(_ noti: Notification) {
        guard let movieInfo = noti.userInfo?["movieInfo"] as? MovieInfo else { return }
        self.movieInfo = movieInfo
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
// MARK: - Collection View Data Source
extension SecondViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func convertNumberFormat(_ num: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: num))!
        
        return result
    }
    func setStarImage(_ arr: Array<UIImageView>, _ rate: Double) {
        let score = rate / 2
        for (index, star) in arr.enumerated() {
            let curr = Double(index)
            if score > curr {
                if (curr..<(curr+0.5)).contains(score) {
                    star.image = UIImage(named: "ic_star_large")
                } else if ((curr+0.5)..<curr+1).contains(score) {
                    star.image = UIImage(named: "ic_star_large_half")
                } else {
                    star.image = UIImage(named: "ic_star_large_full")
                }
            } else {
                star.image = UIImage(named: "ic_star_large")
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: firstCellIdentifier, for: indexPath) as? FirstInfoCollectionViewCell else { fatalError("셀 로드 오류") }
        guard let movieInfo = self.movieInfo else { return cell }
        cell.title.text = movieInfo.title
        cell.date.text = movieInfo.date
        cell.detailInfo.text = "\(movieInfo.genre)/\(movieInfo.duration)분"
        cell.grade.image = UIImage(named: "ic_" + String(movieInfo.grade))
        cell.reservationRate.text = String(movieInfo.reservationRate)
        cell.userRate.text = String(movieInfo.userRating)
        cell.audience.text = convertNumberFormat(movieInfo.audience)
        setStarImage(cell.rateStars, movieInfo.userRating)
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movieInfo.image) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                cell.poster.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }
}
