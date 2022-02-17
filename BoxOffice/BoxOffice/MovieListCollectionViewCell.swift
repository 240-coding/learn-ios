//
//  MovieListCollectionViewCell.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import UIKit

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade: UIImageView!
    @IBOutlet weak var movieInfo: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        self.poster.heightAnchor
    }
}
