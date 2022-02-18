//
//  FirstInfoCollectionViewCell.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/18.
//

import UIKit

class FirstInfoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var detailInfo: UILabel!
    @IBOutlet weak var reservationRate: UILabel!
    @IBOutlet weak var userRate: UILabel!
    @IBOutlet weak var audience: UILabel!
    @IBOutlet var rateStars: Array<UIImageView>!
}
