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
    var selectedCell = Set<IndexPath>()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = navigationTitle
        self.collectionView.allowsMultipleSelection = true
        findTargetCollection()
    }
    
    // MARK: - Right Bar Button Item Action
    @IBAction func pressRightBarButtonItem(_ sender: Any) {
        if self.rightBarButtonItem.title == "선택" {
            self.navigationItem.hidesBackButton = true
            self.rightBarButtonItem.title = "취소"
            self.navigationItem.title = "항목 선택"
            selectBool = true
        } else {
            self.navigationItem.hidesBackButton = false
            self.rightBarButtonItem.title = "선택"
            self.navigationItem.title = self.navigationTitle
            selectBool = false
            // 선택 관련 상태 초기화
            initCellStatus()
            selectCount = 0
        }
    }
    // MARK: - Init Cell Status
    func initCellStatus() {
        for indexPath in selectedCell {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SecondCollectionViewCell else {
                return
            }
            cell.isSelected = false
            cell.setDeselectedStatus()
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? SecondCollectionViewCell else {
            return
        }
        selectedCell.insert(indexPath)
        cell.setSelectedStatus()
        selectCount += 1
        self.navigationItem.title = "\(selectCount)장 선택"
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SecondCollectionViewCell else {
            return
        }
        selectedCell.remove(indexPath)
        cell.setDeselectedStatus()
        selectCount -= 1
        self.navigationItem.title = selectCount == 0 ? "항목 선택" : "\(selectCount)장 선택"
    }
    // MARK: - Collection View Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = view.frame.width * 0.94 / 3
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    // MARK: - Find Target Collection
    func findTargetCollection() {
        let fetchOptions = PHFetchOptions()
        guard let localIdentifier = localIdentifier else {
            return
        }
        let collection = PHAssetCollection.fetchAssetCollections(withLocalIdentifiers: [localIdentifier], options: nil)
        if let targetCollection = collection.firstObject {
            self.fetchResult = PHAsset.fetchAssets(in: targetCollection, options: nil)
        } else {
        }
        print(fetchResult)
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
