//
//  ThirdViewController.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/12.
//

import UIKit
import Photos

class ThirdViewController: UIViewController, UIScrollViewDelegate, PHPhotoLibraryChangeObserver {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var favoriteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var deleteBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    var localIdentifier: String!
    var asset: PHAsset!
    var navigationItemTitle: String?
    var navigationItemSubtitle: String?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let targetAsset = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject else {
            return
        }
        asset = targetAsset
        PHPhotoLibrary.shared().register(self)
        setNavigationItemTitleText()
        setImageViewImage()
        setFavoriteBarButtomItemStatus()
    }
    deinit {
        PHPhotoLibrary.shared().unregisterChangeObserver(self)
    }
    // MARK: - Set ImageView And ScrollViewDelegate
    func setImageViewImage() {
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in self.imageView.image = image })
    }
    @IBAction func scrollViewGestureRecognizer(_ sender: UITapGestureRecognizer) {
        guard let isNavigationBarHidden = self.navigationController?.isNavigationBarHidden, let isToolbarHidden = self.navigationController?.isToolbarHidden else {
            return
        }
        self.navigationController?.isNavigationBarHidden = isNavigationBarHidden ? false : true
        self.navigationController?.setToolbarHidden(!isToolbarHidden, animated: false)
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    // MARK: - Set Favorite Status
    func setFavoriteBarButtomItemStatus() {
        self.favoriteBarButtonItem.title = asset.isFavorite ? "❤️" : "🖤"
    }
    @IBAction func touchFavoriteBarButtonItem(_ sender: Any) {
        PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest(for: self.asset).isFavorite = !self.asset.isFavorite}, completionHandler: nil)
        if self.favoriteBarButtonItem.title == "❤️" {
            self.favoriteBarButtonItem.title = "🖤"
        } else {
            self.favoriteBarButtonItem.title = "❤️"
        }
    }
    // MARK: - Delete Photo
    @IBAction func touchDeleteBarButtonItem(_ sender: Any) {
        PHPhotoLibrary.shared().performChanges({ PHAssetChangeRequest.deleteAssets([self.asset!] as NSArray) }, completionHandler: nil)
    }
    // MARK: - Set navigationItem Title Text
    func setNavigationItemTitleText() {
        let dateFormatter: DateFormatter = {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(identifier: "UTC")
            return formatter
        }()
        let timeFormatter: DateFormatter = {
            let formatter: DateFormatter = DateFormatter()
            formatter.dateFormat = "a hh:mm:ss"
            formatter.amSymbol = "AM"
            formatter.pmSymbol = "PM"
            return formatter
        }()
        guard let assetDateInfo = asset.creationDate else {
            return
        }
        self.titleLabel.text = dateFormatter.string(from: assetDateInfo)
        self.subtitleLabel.text = timeFormatter.string(from: assetDateInfo)
    }
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let change = changeInstance.changeDetails(for: asset) else {
            return
        }
        if change.objectWasDeleted {
            OperationQueue.main.addOperation {
                self.navigationController?.popViewController(animated: true)
            }
        } else {
            self.asset = change.objectAfterChanges
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
