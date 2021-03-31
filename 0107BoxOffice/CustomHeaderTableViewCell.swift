//
//  CustomHeaderTableViewCell.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/15.
//

import UIKit

class CustomHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var outletWhiteButton: UIButton!
    @IBAction func whiteButton(_ sender: Any) {
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
