//
//  CustomDetaalTableViewCell.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/03.
//

import UIKit

class CustomDetailTableViewCell: UITableViewCell {

    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleImage: UIImageView!
    
    @IBOutlet weak var reservationRateText: UILabel!
    @IBOutlet weak var userRatingText: UILabel!
    @IBOutlet weak var CumulativeAudienceText: UILabel!
    
    @IBOutlet weak var reservationRate: UILabel!
    @IBOutlet weak var userRating: UILabel!
    @IBOutlet var oneImage: UIImageView!
    @IBOutlet var twoImage: UIImageView!
    @IBOutlet var threeImage: UIImageView!
    @IBOutlet var fourImage: UIImageView!
    @IBOutlet var fiveImage: UIImageView!
    @IBOutlet weak var CumulativeAudience: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        if selected {
//            backgroundColor = UIColor.lightGray
//        } else {
//            backgroundColor = UIColor.clear
//        }
        // Configure the view for the selected state
    }
    
//    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
//        if highlighted {
//            backgroundColor = UIColor.lightGray
//        } else {
//            backgroundColor = UIColor.clear
//        }
//    }

}
