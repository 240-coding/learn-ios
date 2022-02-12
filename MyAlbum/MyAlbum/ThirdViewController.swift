//
//  ThirdViewController.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/12.
//

import UIKit
import Photos

class ThirdViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var toolbar: UIToolbar!
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
        setNavigationItemTitleText()
        setImageViewImage()
    }
    // MARK: - Set ImageView And ScrollViewDelegate
    func setImageViewImage() {
        PHImageManager.default().requestImage(for: asset, targetSize: CGSize(width: asset.pixelWidth, height: asset.pixelHeight), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in self.imageView.image = image })
    }
    @IBAction func scrollViewGestureRecognizer(_ sender: UITapGestureRecognizer) {
        guard let isNavigationBarHidden = self.navigationController?.isNavigationBarHidden else {
            return
        }
        self.navigationController?.isNavigationBarHidden = isNavigationBarHidden ? false : true
        self.toolbar.isHidden = toolbar.isHidden ? false : true
    }
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.navigationController?.isNavigationBarHidden = true
        self.toolbar.isHidden = true
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
