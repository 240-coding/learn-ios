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
    let cellIdentifier = ["firstInfoCell", "secondInfoCell", "thirdInfoCell", "fourthInfoCell"]
    let headerIdentifier = "titleHeader"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieInfoNotification(_:)), name: DidReceiveMovieInfoNotification, object: nil)
        if let movieId = movieId {
            requestMovieInfo(movieId)
        }
        self.navigationController?.navigationBar.tintColor = .white
    }
    // MARK: - Notification Observer
    @objc func didReceiveMovieInfoNotification(_ noti: Notification) {
        guard let movieInfo = noti.userInfo?["movieInfo"] as? MovieInfo else { return }
        self.movieInfo = movieInfo
        DispatchQueue.main.async {
            self.navigationItem.title = self.movieInfo?.title ?? ""
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
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
    // MARK: - cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[0], for: indexPath) as? FirstInfoCollectionViewCell else { fatalError("셀 로드 오류") }
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
        } else if indexPath.section == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[1], for: indexPath) as? SecondInfoCollectionViewCell else { fatalError("셀 로드 오류")}
            guard let movieInfo = self.movieInfo else { return cell }
            cell.synopsis.text = movieInfo.synopsis
            
            return cell
        } else if indexPath.section == 2 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[2], for: indexPath) as? ThirdInfoCollectionViewCell else { fatalError("셀 로드 오류")}
            guard let movieInfo = self.movieInfo else { return cell }
            cell.director.text = movieInfo.director
            cell.actor.text = movieInfo.actor
            
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[1], for: indexPath) as? SecondInfoCollectionViewCell else { fatalError("셀 로드 오류")}
        return cell
    }
    // MARK: - Set Header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as? TitleCollectionReusableView else { fatalError("헤더 로드 오류")}
        if indexPath.section == 1 {
            headerView.title.text = "줄거리"
            headerView.btn.isHidden = true
            return headerView
        } else if indexPath.section == 2 {
            headerView.title.text = "감독/출연"
            headerView.btn.isHidden = true
            return headerView
        } else if indexPath.section == 3 {
            headerView.title.text = "한줄평"
            headerView.btn.isHidden = false
            return headerView
        }
        return headerView
    }
}
// MARK: - Collection View Flow Layout
extension SecondViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        if indexPath.section == 0 {
            return CGSize(width: width, height: 300)
        } else if indexPath.section == 1 {
            return CGSize(width: width, height: 500)
        } else if indexPath.section == 2 {
            return CGSize(width: width, height: 100)
        } else {
            return CGSize(width: width, height: 150)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        } else {
            return CGSize(width: view.frame.width, height: 40)
        }
    }
}