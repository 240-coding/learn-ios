//
//  ThirdViewController.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/12.
//

import UIKit

class ThirdViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
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
        guard let title = navigationItemTitle, let subtitle = navigationItemSubtitle else {
            print("실패")
            return
        }
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
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
