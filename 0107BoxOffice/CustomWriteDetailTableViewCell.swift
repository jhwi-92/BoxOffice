//
//  CustomWriteDetailTableViewCell.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/23.
//

import UIKit

//protocol CustomCellTextFieldDelegate: class {
//    func textFieldText(nameText: String, contentsText: String)
//}

class CustomWriteDetailTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    //weak var delegate: CustomCellTextFieldDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var contents: UITextField!
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        name.delegate = self
        contents.delegate = self
        if WriteInfo.shared.writer != nil {
            name.text = WriteInfo.shared.writer!
        }

        // Configure the view for the selected state
    }
    
//    @IBAction func textFieldTextDelegate(sender: Any) {
//        
//        delegate?.textFieldText(nameText: name.text!, contentsText: contents.text!)
//    }

//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        //placeholder보다 더 좋은 방법찾기...
//         print(textField.placeholder)
//         if textField.placeholder == "닉네임을 입력해주세요" {
//            WriteInfo.shared.writer = textField.text!
//         }else if textField.placeholder == "한줄평을 작성해주세요" {
//            WriteInfo.shared.contents = textField.text!
//         }
//    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        //placeholder보다 더 좋은 방법찾기...
        if textField.placeholder == "닉네임을 입력해주세요" {
           WriteInfo.shared.writer = textField.text!
        }else if textField.placeholder == "한줄평을 작성해주세요" {
           WriteInfo.shared.contents = textField.text!
        }
    }
    
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//         print(textField.placeholder)
//        //placeholder보다 더 좋은 방법찾기...
//        if textField.placeholder == "닉네임을 입력해주세요" {
//           WriteInfo.shared.writer = textField.text!
//        }else if textField.placeholder == "한줄평을 작성해주세요" {
//           WriteInfo.shared.contents = textField.text!
//        }
//    }
}
