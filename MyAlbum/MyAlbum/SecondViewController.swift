//
//  SecondViewController.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/05.
//

import UIKit
import Photos

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var rightBarButtonItem: UIBarButtonItem!
    
    var localIdentifier: String?
    var navigationTitle: String?
    var cellIdentifier: String = "secondCell"
    var fetchResult: PHFetchResult<PHAsset>?
    var selectCount = 0
    var selectBool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = navigationTitle
        findTargetCollection()
    }
    
    // MARK: - Right Bar Button Item Action
    @IBAction func pressRightBarButtonItem(_ sender: Any) {
        if self.rightBarButtonItem.title == "선택" {
            print("선택")
            self.rightBarButtonItem.title = "취소"
            self.navigationItem.title = "항목 선택"
            selectBool = true
        } else {
            print("취소")
            self.rightBarButtonItem.title = "선택"
            selectBool = false
        }
    }
    // MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? SecondCollectionViewCell else {
            fatalError()
        }
        guard let assets = fetchResult else {
            return cell
        }
        let imageAsset = assets.object(at: indexPath.item)
        PHImageManager.default().requestImage(for: imageAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.image?.image = image})
        
        return cell
    }
    // MARK: - Collection View Delegate
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return selectBool
    }
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return selectBool
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectCount += 1
        print(selectCount)
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectCount -= 1
        print(selectCount)
    }
    // MARK: - Collection View Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width * 0.94 / 3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
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
