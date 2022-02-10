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
    @IBOutlet weak var photoOrderBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var deletePhotoBarButtonItem: UIBarButtonItem!
    
    var localIdentifier: String?
    var targetCollection: PHAssetCollection?
    var navigationTitle: String?
    var cellIdentifier: String = "secondCell"
    var fetchResult: PHFetchResult<PHAsset>?
    var selectCount = 0
    var selectBool = false
    var selectedCell = Set<IndexPath>()
    var selectedCellImageInfo = Set<String?>()

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
            self.shareBarButtonItem.isEnabled = true
            self.deletePhotoBarButtonItem.isEnabled = true
        } else {
            self.navigationItem.hidesBackButton = false
            self.rightBarButtonItem.title = "선택"
            self.navigationItem.title = self.navigationTitle
            selectBool = false
            self.shareBarButtonItem.isEnabled = false
            self.deletePhotoBarButtonItem.isEnabled = false
            // 선택 관련 상태 초기화
            initCellStatus()
            selectedCell.removeAll()
            selectedCellImageInfo.removeAll()
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
    // MARK: - Set Photos Order
    @IBAction func pressUpPhotoOrderBarItemButton(_ sender: Any) {
        let fetchOptions = PHFetchOptions()
        if self.photoOrderBarButtonItem.title == "최신순" {
            self.photoOrderBarButtonItem.title = "과거순"
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        } else {
            self.photoOrderBarButtonItem.title = "최신순"
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        }
        if let targetCollection = targetCollection {
            self.fetchResult = PHAsset.fetchAssets(in: targetCollection, options: fetchOptions)
            OperationQueue.main.addOperation {
                self.collectionView.reloadData()
            }
        }
    }
    // MARK: - Share Bar Item Button
    @IBAction func pressUpShareBarItemButton(_ sender: Any) {
        let activityItems: [UIImage] = importUIImageFromPHAsset()
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
//        activityViewController.completionWithItemsHandler = {(activity, success, items, error) in
//            if success {
//                print("공유 성공")
//            } else {
//                print("공유 실패")
//            }
//        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func importUIImageFromPHAsset() -> [UIImage] {
        var selectedImages = [UIImage]()
        for localIdentifier in selectedCellImageInfo {
            guard let localIdentifier = localIdentifier else {
                continue
            }
            guard let asset = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject else {
                continue
            }

            PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFill, options: nil, resultHandler: {image, _ in guard let image = image else {
                return
            }
                selectedImages.append(image)})
            
        }
        print(selectedImages)
        return selectedImages
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
        cell.localIdentifier = imageAsset.localIdentifier
        
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
        selectedCellImageInfo.insert(cell.localIdentifier)
        cell.setSelectedStatus()
        selectCount += 1
        self.navigationItem.title = "\(selectCount)장 선택"
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SecondCollectionViewCell else {
            return
        }
        selectedCell.remove(indexPath)
        selectedCellImageInfo.remove(cell.localIdentifier)
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
        targetCollection = collection.firstObject
        if let targetCollection = collection.firstObject {
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            self.fetchResult = PHAsset.fetchAssets(in: targetCollection, options: fetchOptions)
        } else {
            fatalError()
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
