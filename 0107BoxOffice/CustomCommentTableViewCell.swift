//
//  CustomCommentTableViewCell.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/15.
//

import UIKit

class CustomCommentTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userDate: UILabel!
    @IBOutlet weak var userComment: UILabel!
    @IBOutlet var oneImage: UIImageView!
    @IBOutlet var twoImage: UIImageView!
    @IBOutlet var threeImage: UIImageView!
    @IBOutlet var fourImage: UIImageView!
    @IBOutlet var fiveImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
