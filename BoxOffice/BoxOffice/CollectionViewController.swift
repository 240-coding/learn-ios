//
//  CollectionViewController.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import UIKit

class CollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var movieList: [MovieList] = []
    let cellIdentifier = "movieListCollectionCell"

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        requestMovieList("0")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveMovieListNotification(_:)), name: DidReceiveMovieListNotification, object: nil)
    }
    
    @objc func didReceiveMovieListNotification(_ noti: Notification) {
        guard let movieList = noti.userInfo?["movieList"] as? [MovieList] else { return }
        
        self.movieList = movieList
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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

// MARK: - UICollectionViewDataSource
extension CollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: MovieListCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? MovieListCollectionViewCell else { fatalError("셀 불러오기 실패") }
        let movie = self.movieList[indexPath.item]
        
        cell.poster.image = nil
        cell.title.text = movie.title
        cell.grade.image = UIImage(named: "ic_" + String(movie.grade))
        cell.movieInfo.text = movie.movieInfo
        cell.date.text = movie.date
        
        DispatchQueue.global().async {
            guard let imageURL: URL = URL(string: movie.thumb) else { return }
            guard let imageData: Data = try? Data(contentsOf: imageURL) else { return }
            DispatchQueue.main.async {
                if let index: IndexPath = self.collectionView.indexPath(for: cell) {
                    if index.item == indexPath.item {
                        cell.poster.image = UIImage(data: imageData)
                        cell.setNeedsLayout()
                        cell.layoutIfNeeded()
                    }
                }
            }
        }
        
        return cell
    }
}

// MARK: - UICollectionViewFlowLayout
extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = view.frame.width / 2 - 15

        return CGSize(width: availableWidth, height: availableWidth + 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
    }
}
