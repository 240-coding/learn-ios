//
//  ThirdViewController.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/12.
//

import UIKit
import Photos

class ThirdViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    var localIdentifier: String!
    var navigationItemTitle: String?
    var navigationItemSubtitle: String?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationItemTitleText()
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
        guard let assetDateInfo = PHAsset.fetchAssets(withLocalIdentifiers: [localIdentifier], options: nil).firstObject?.creationDate else {
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
