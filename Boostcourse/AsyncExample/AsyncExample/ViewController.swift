//
//  ViewController.swift
//  AsyncExample
//
//  Created by 이서영 on 2022/01/29.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func touchUpDownloadButton(_ sender: UIButton) {
        // 이미지 다운로드 -> 이미지 뷰에 세팅
        
        // https://www.hellokpop.com/wp-content/uploads/2019/01/Beomgyu.jpg
        
        let imageURL: URL = URL(string: "https://www.hellokpop.com/wp-content/uploads/2019/01/Beomgyu.jpg")!
        
        OperationQueue().addOperation {
            let imageData: Data = try! Data.init(contentsOf: imageURL)
            let image: UIImage = UIImage(data: imageData)!
            
            OperationQueue.main.addOperation {
                self.imageView.image = image
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

