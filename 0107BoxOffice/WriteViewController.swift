//
//  WriteViewController.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/23.
//

import UIKit

let DidDismissWriteViewController: Notification.Name = Notification.Name("DidDismissWriteViewController")


class WriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    //var commentRequestData: commentRequest?
    var jsonData: MovieDetail?
    //let ViewController = WriteViewController()
    //let Util: Util
    
    //var Util: Util = Util()

    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell: CustomWriteGradeTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "writeGradeCell", for: indexPath) as? CustomWriteGradeTableViewCell else {return CustomWriteGradeTableViewCell()}
            cell.movieTitle.text = self.jsonData!.title
            cell.movieAge.image = UIImage(named: self.jsonData!.ageImageName)
            //cell배열에 데이터를 담기 위해 delegate사용
            cell.delegate = self
            
            return cell
        } else {
            guard let cell: CustomWriteDetailTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "writeDetailCell", for: indexPath) as? CustomWriteDetailTableViewCell else {return CustomWriteDetailTableViewCell()}
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        } else {
            return 0
        }
    }

    override func viewDidLoad() {
        //super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(animated)
        
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        WriteInfo.shared.movieId = jsonData!.id
        WriteInfo.shared.rating = 10
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func commitButton(_ sender: Any) {
        //textFieldText(nameText: String, contentsText: String)
        print("commentRequest")
        //
        guard WriteInfo.shared.writer != nil else {
            print("aa")
            Util.showAlert(viewController: WriteViewController(), title: "알림",
                               msg: "작성자를 입력해주세요",
                               buttonTitle: "확인") { (UIAlertAction) in
                print("1")
            }
            //Util.showAlert(<#T##self: Util##Util#>)
//            Util.showAlert(viewController: ViewController, title: "알림", msg: "작성자를 입력해주세요", buttonTitle: "확인", handler: nil)
            
//            let alert = UIAlertController(title: "알림", message: "작성자를 입력해주세요", preferredStyle: .alert)
//            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
//            }
//            alert.addAction(okAction)
//            present(alert, animated: false, completion: nil)
            return
        }
        guard WriteInfo.shared.contents != nil else {
            
            let alert = UIAlertController(title: "알림", message: "내용을 입력해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
            }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            return
        }
        //let paramText = ""
        dataConnect(getURL: "https://connect-boxoffice.run.goorm.io/comment")
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func dataConnect(getURL: String) {
        
        //데이터 변환
        //WriteInfo
        let paramText = "{\"writer\":\"\(WriteInfo.shared.writer!)\",\"contents\":\"\(WriteInfo.shared.contents!)\",\"movie_id\":\"\(WriteInfo.shared.movieId!)\",\"rating\":\(WriteInfo.shared.rating!)}"

        let paramData = paramText.data(using: .utf8)

        // URL 객체 정의
        guard let url: URL = URL(string: getURL) else {return}

        // URL Request 객체 정의
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = paramData!
        
        // HTTP 메시지 헤더
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")

        // URLSession 객체를 통해 전송, 응답값 처리
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // 서버가 응답이 없거나 통신이 실패
            if let e = error {
              NSLog("An error has occured: \(e.localizedDescription)")
              return
            }

            // 응답 처리 로직
            DispatchQueue.main.async() {
                // 서버로부터 응답된 스트링 표시
                let outputStr = String(data: data!, encoding: String.Encoding.utf8)
                print("data:")
                print("result: \(outputStr!)")
                if outputStr != nil {
                    self.success()
                }
            }
        }
        // POST 전송
        task.resume()
        
        
      
    }
    
    func success () {
        NotificationCenter.default.post(name: DidDismissWriteViewController, object: nil, userInfo: nil)
        //contents 내용 초기화
        WriteInfo.shared.contents = nil
        self.dismiss(animated: true, completion: nil)
        
    }

}


extension WriteViewController: CustomCellDelegate {

    
  func customCell(_ customCell: CustomWriteGradeTableViewCell, sliderValueChanged value: Int) {
    
        var current = value //UISlider(sender)의 value를 current라는 변수로 보낸다.
    
        customCell.grade.text = "\(current)" // value의 text가 나타내는것은 current의 값이다.
            for i in 0...4{
                var countImage: UIImageView = customCell.oneImage
                switch i {
                case 0:
                    countImage = customCell.oneImage
                    break
                case 1:
                    countImage = customCell.twoImage
                    break
                case 2:
                    countImage = customCell.threeImage
                    break
                case 3:
                    countImage = customCell.fourImage
                    break
                case 4:
                    countImage = customCell.fiveImage
                    break
                default:
                    break
                }
                if current >= (i + 1) * 2 {
                    countImage.image = UIImage(named: "ic_star_large_full")
                } else if current > i * 2 {
                    countImage.image = UIImage(named: "ic_star_large_half")
                } else {
                    countImage.image = UIImage(named: "ic_star_large")
                }
            }
    WriteInfo.shared.rating = Double(value)
  }
    
    
}
