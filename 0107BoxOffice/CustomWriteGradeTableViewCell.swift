//
//  CustomWriteGradeTableViewCell.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/23.
//

import UIKit


protocol CustomCellDelegate: class {
  func customCell(_ customCell: CustomWriteGradeTableViewCell, sliderValueChanged value: Int)
}

class CustomWriteGradeTableViewCell: UITableViewCell {
    
    weak var delegate: CustomCellDelegate?

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieAge: UIImageView!
    
    @IBOutlet weak var oneImage: UIImageView!
    @IBOutlet weak var twoImage: UIImageView!
    @IBOutlet weak var threeImage: UIImageView!
    @IBOutlet weak var fourImage: UIImageView!
    @IBOutlet weak var fiveImage: UIImageView!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var sliderGrade: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        oneImage.image = UIImage(named: "ic_star_large_full")
        twoImage.image = UIImage(named: "ic_star_large_full")
        threeImage.image = UIImage(named: "ic_star_large_full")
        fourImage.image = UIImage(named: "ic_star_large_full")
        fiveImage.image = UIImage(named: "ic_star_large_full")
        grade.text = "10"
        sliderGrade.value = 10
        
        // Configure the view for the selected state
    }
    
    @IBAction func sliderValueChanged(sender: UISlider) {
        
        delegate?.customCell(self, sliderValueChanged: Int(sender.value))

//    var current = Int(sender.value) //UISlider(sender)의 value를 Int로 캐스팅해서 current라는 변수로 보낸다.
//
//    grade.text = "\(current)" // value의 text가 나타내는것은 current의 값이다.
//        for i in 0...4{
//            var countImage: UIImageView = oneImage
//            switch i {
//            case 0:
//                countImage = oneImage
//                break
//            case 1:
//                countImage = twoImage
//                break
//            case 2:
//                countImage = threeImage
//                break
//            case 3:
//                countImage = fourImage
//                break
//            case 4:
//                countImage = fiveImage
//                break
//            default:
//                break
//            }
//            if current >= (i + 1) * 2 {
//                countImage.image = UIImage(named: "ic_star_large_full")
//            } else if current > i * 2 {
//                countImage.image = UIImage(named: "ic_star_large_half")
//            } else {
//                countImage.image = UIImage(named: "ic_star_large")
//            }
//        }

    }
    

}
