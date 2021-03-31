//
//  CustomActorTableViewCell.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/15.
//

import UIKit

class CustomActorTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var directorTitle: UILabel!
    @IBOutlet weak var actorTitle: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        title.text = "감독/출연"
        directorTitle.text = "감독"
        actorTitle.text = "출연"
        // Configure the view for the selected state
    }

}
