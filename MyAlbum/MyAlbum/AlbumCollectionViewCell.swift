//
//  AlbumCollectionViewCell.swift
//  MyAlbum
//
//  Created by 이서영 on 2022/02/03.
//

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var albumName: UILabel!
    @IBOutlet var albumPhotoCount: UILabel!
    
    override func awakeFromNib() {
        image.layer.cornerRadius = 5.0
        image.layer.masksToBounds = true
    }
}
