//
//  SecondCollectionViewCell.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/08.
//

import UIKit

class SecondCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    var localIdentifier: String?
    
    override func awakeFromNib() {
        image.isOpaque = true
    }
    
    func setSelectedStatus() {
        image.alpha = 0.7
        image.layer.borderWidth = 3
    }
    func setDeselectedStatus() {
        image.alpha = 1
        image.layer.borderWidth = 0
    }
}
