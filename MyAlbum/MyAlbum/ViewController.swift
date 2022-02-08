//
//  ViewController.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/03.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, PHPhotoLibraryChangeObserver {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier: String = "cell"
    var fetchResult: PHFetchResult<PHAssetCollection>?
    private let sectionInsets = UIEdgeInsets(
      top: 10.0,
      left: 5.0,
      bottom: 10.0,
      right: 5.0)
    private let itemsPerRow: CGFloat = 2

    // MARK: - Load View
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "앨범"
        self.requestPhotoLibraryAccess()
        PHPhotoLibrary.shared().register(self)
    }

    // MARK: - Collection View Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.fetchResult?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? AlbumCollectionViewCell else {
            fatalError("Unable to dequeue AlbumCollectionViewCell")
        }
        guard let collection = fetchResult?[indexPath.item] else {
            return cell
        }
        let fetchedAssets = PHAsset.fetchAssets(in: collection, options: nil)
        if let coverAsset = fetchedAssets.lastObject {
            PHImageManager.default().requestImage(for: coverAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .aspectFill, options: nil, resultHandler: {image, _ in cell.image?.image = image})
        } else {
            cell.image.image = nil
        }
        
        cell.albumName.text? = collection.localizedTitle ?? ""
        cell.albumPhotoCount.text? = String(fetchedAssets.count)
        cell.localIdentifier = collection.localIdentifier
        
        return cell
    }
    // MARK: - Collection View Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = self.sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width/2 - paddingSpace
        let widthPerItem = availableWidth
        
        return CGSize(width: widthPerItem, height: widthPerItem + 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    // MARK: - Photo Library Methods
    func requestCollection() {
        // Need options?
        print("컬렉션 불러오기")
        self.fetchResult = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: nil)
    }
    func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                // The user hasn't determined this app's access.
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                    switch status {
                    case .authorized:
                        self.requestCollection()
                        OperationQueue.main.addOperation {
                            self.collectionView.reloadData()
                        }
                    case .denied:
                        print("사용자가 불허함")
                    default: break
                    }
                }
            case .authorized:
                // The user authorized this app to access Photos data.
                print("허용")
                self.requestCollection()
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
                }
//                OperationQueue.main.waitUntilAllOperationsAreFinished()
            case .denied:
                print("사용자가 불허함")
            default:
                fatalError()
            }
        }
    }
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: self.fetchResult!) else {
            return
        }
        fetchResult = changes.fetchResultAfterChanges
        OperationQueue.main.addOperation {
//            self.collectionView.reloadSections(IndexSet(0...0), with: .automatic)
            self.collectionView.reloadSections(IndexSet(0...0))
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let nextViewController = segue.destination as? SecondViewController else {
            return
        }
        guard let cell = sender as? AlbumCollectionViewCell else {
            return
        }
        nextViewController.localIdentifier = cell.localIdentifier
        nextViewController.navigationTitle = cell.albumName.text
    }
}

