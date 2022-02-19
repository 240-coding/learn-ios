//
//  ThirdViewController.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/20.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier = ["firstCommentCell", "secondCommentCell"]
    var movieTitle: String?
    var movieGrade: Int?
    var stars: Array<UIImageView> = []
    var userRate: UILabel!
    var commentInfo = UserComment()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    @IBAction func pressCancelBarButtonItem() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func pressDoneBarButtonItem() {
        print("Done")
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
extension ThirdViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    @objc func changeSliderValue(_ sender: UISlider) {
        self.commentInfo.rating = floor(Double(sender.value))
        setStarImage(stars)
        self.userRate.text = String(Int(self.commentInfo.rating!))
    }
    func setStarImage(_ arr: Array<UIImageView>) {
        let score = commentInfo.rating! / 2
        for (index, star) in arr.enumerated() {
            let curr = Double(index)
            if score > curr {
                if index == Int(score) {
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
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[0], for: indexPath) as? FirstCommentCollectionViewCell else { fatalError("셀 로드 오류") }
            cell.title.text = self.movieTitle ?? "None"
            cell.grade.image = UIImage(named: "ic_" + String(self.movieGrade ?? 12))
            setStarImage(cell.starRate)
            cell.rate.text = "10"
            self.stars = cell.starRate
            self.userRate = cell.rate
            cell.slider.addTarget(self, action: #selector(changeSliderValue(_:)), for: UIControl.Event.valueChanged)
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[0], for: indexPath) as? FirstCommentCollectionViewCell else { fatalError("셀 로드 오류") }
            return cell
        }
    }
}
// MARK: - Collection View Flow Layout
extension ThirdViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let height = view.frame.height
        if indexPath.section == 0 {
            return CGSize(width: width, height: 150)
        } else {
            return CGSize(width: width, height: height - 150)
        }
    }
}
