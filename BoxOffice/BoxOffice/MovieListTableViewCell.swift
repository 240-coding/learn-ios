//
//  MovieListTableViewCell.swift
//  BoxOffice
//
//  Created by 이서영 on 2022/02/15.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var grade: UIImageView!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet weak var reservationGrade: UILabel!
    @IBOutlet weak var reservationRate: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
