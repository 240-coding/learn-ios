//
//  ThirdViewController.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/20.
//

import UIKit

class ThirdViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let cellIdentifier = ["firstCommentCell", "secondCommentCell"]
    var movieTitle: String?
    var movieGrade: Int?
    var stars: Array<UIImageView> = []
    var userRate: UILabel!
    var userName: UITextField!
    var userComment: UITextView!
    var commentInfo = UserComment()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.tintColor = .white
        NotificationCenter.default.addObserver(self, selector: #selector(didPostCommentNotification), name: DidPostCommentNotification, object: nil)
    }
    // MARK: - Notification Observer
    @objc func didPostCommentNotification() {
        DispatchQueue.main.async {
            self.dismiss(animated: true, completion: {
                NotificationCenter.default.post(name: ShouldReloadComments, object: nil)
            })
        }
    }
    // MARK: - @IBAction Methods
    @IBAction func pressCancelBarButtonItem() {
        self.appDelegate.username = self.userName.text ?? ""
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func pressDoneBarButtonItem() {
        self.appDelegate.username = self.userName.text ?? ""
        if let writer = userName.text, let comment = userComment.text {
            if writer.isEmpty || comment.isEmpty {
                self.showAlertController()
            } else {
                commentInfo.writer = writer
                commentInfo.contents = comment
                postComment(commentInfo)
            }
        }
    }
    @IBAction func tapView(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    // MARK: - Alert Controller
    func showAlertController() {
        let alertController = UIAlertController(title: "한줄평 등록", message: "닉네임 및 한줄평을 작성하셔야 합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier[1], for: indexPath) as? SecondCommentCollectionViewCell else { fatalError("셀 로드 오류") }
            self.userName = cell.nicknameTextField
            self.userComment = cell.commentTextView
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
