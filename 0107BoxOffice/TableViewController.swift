//
//  TableViewController.swift
//  0107BoxOffice
//
//  Created by jh on 2021/01/11.
//

import UIKit

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "movieCell"
    var movieInfos: [MovieInfo] = []
    var orderType: String = "0"
    
//    @IBOutlet weak var stackView: UIStackView!
    
    //뷰가 로드되었을 때
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "예매율"
        // Do any additional setup after loading the view.
    }
    //뷰가 나타났을 떄.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        //api호출
        dataConnect()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movieInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: CustomTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? CustomTableViewCell else {return CustomTableViewCell()}
        
        cell.dateLabel?.text = "개봉일 : " + self.movieInfos[indexPath.row].date
        cell.titleLabel?.text = self.movieInfos[indexPath.row].title
        cell.detailLabel?.text = self.movieInfos[indexPath.row].full
        
//        if let text = cell.titleLabel?.text{
                    
            let attributedString = NSMutableAttributedString(string: self.movieInfos[indexPath.row].title)
//            cell.titleLabel.attributedText = attributedString
//        }
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: self.movieInfos[indexPath.row].ageImageName)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        
        cell.titleLabel.attributedText = attributedString
        let imageURL: URL = URL(string: movieInfos[indexPath.row].thumb)!
        
        OperationQueue().addOperation {
            do {
                let imageData: Data = try Data.init(contentsOf: imageURL)
                let image: UIImage = UIImage(data: imageData)!
                
                OperationQueue.main.addOperation {
                    cell.titleImage.image = image
                }
            } catch {
                print("데이터 없음")
                print(self.movieInfos[indexPath.row].thumb)
            }
           
            
            
            
        }
//        cell.ageImage?.image = UIImage(named: self.movieInfos[indexPath.row].ageImageName)
        
        //cell.titleLabel.sizeToFit()
        //cell.titleLabel.adjustsFontSizeToFitWidth = true
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func setSort(_ sender: Any) {
        
        showAlert()
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "정렬방식 선택", message: "영화를 어떤 순서로 정렬할까요?", preferredStyle: .actionSheet)
        
        let ticketing = UIAlertAction(title: "예매율", style: .default) { (UIAlertAction) in
            self.orderTypeCheck(orderType: "0")
        }
        let curation = UIAlertAction(title: "큐레이션", style: .default) { (UIAlertAction) in
            self.orderTypeCheck(orderType: "1")
        }
        let openingDate = UIAlertAction(title: "개봉일", style: .default) { (UIAlertAction) in
            self.orderTypeCheck(orderType: "2")
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(ticketing)
        alert.addAction(curation)
        alert.addAction(openingDate)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    func orderTypeCheck(orderType: String) {
        guard (self.orderType == orderType) else {
            self.orderType = orderType
            switch self.orderType {
            case "0":
                self.navigationItem.title = "예매율"
            case "1":
                self.navigationItem.title = "큐레이션"
            case "2":
                self.navigationItem.title = "개봉일"
            default:
                return
            }
            dataConnect()
            return
        }
    }
    func dataConnect() {
        guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type="+self.orderType) else {return}
        
        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {return}
            
            do {
                let apiResponse: APIMoviesResponse = try JSONDecoder().decode(APIMoviesResponse.self, from: data)
                self.movieInfos = apiResponse.movies
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
                
            } catch(let err) {
                print(err.localizedDescription)
            }
            
        }
        dataTask.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: DetailViewController = segue.destination as? DetailViewController else {
            return
        }
        
        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {
            return
        }
        
        nextViewController.jsonData = movieInfos[selectedRow]
    }
    
}
