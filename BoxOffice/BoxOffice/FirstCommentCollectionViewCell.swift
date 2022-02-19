//
//  FirstCommentCollectionViewCell.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/20.
//

import UIKit

class FirstCommentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet var starRate: Array<UIImageView>!
    @IBOutlet weak var rate: UILabel!
}
