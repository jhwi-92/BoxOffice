//
//  CollectionViewController.swift
//  0107BoxOffice
//
//  Created by jh on 2021/01/11.
//

import UIKit

class CollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    let cellIdentifier: String = "movieCell"
    var movieInfos: [MovieInfo] = []
    //var orderType: String = "0"
    
    @IBAction func setSort(_ sender: Any) {
        
        showAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch Setting.shared.orderType {
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
        

        // Do any additional setup after loading the view.
        
        //스토리보드에서 설정하였음, 생략
//        self.collectionView.delegate = self
//        self.collectionView.dataSource = self
    }
    
    //뷰가 나타났을 떄.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.orderTypeCheck(orderType: Setting.shared.orderType!)
        //api호출
        //dataConnect()
    }
    
    //컬렉션 섹션의 내용 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieInfos.count
    }
    
    //셀 내용 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? CustomCollectionViewCell
        else {
            return CustomCollectionViewCell()
        }
        //cell.backgroundColor = .black
        cell.dateLabel?.text = self.movieInfos[indexPath.row].date
        cell.titleLabel?.text = self.movieInfos[indexPath.row].title
        cell.detailLabel?.text = self.movieInfos[indexPath.row].gradeRatingRate
        cell.ageImage.image = UIImage(named: self.movieInfos[indexPath.row].ageImageName)
        
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
        
        return cell
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
        guard (Setting.shared.orderType == orderType) else {
            Setting.shared.orderType = orderType
            switch Setting.shared.orderType {
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
        guard let url: URL = URL(string: "https://connect-boxoffice.run.goorm.io/movies?order_type=" + Setting.shared.orderType!) else {return}
        
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
                print("movieInfos")
                print(self.movieInfos)
                OperationQueue.main.addOperation {
                    self.collectionView.reloadData()
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
        
        guard let selectedRow = collectionView.indexPathsForSelectedItems else {
            return
        }
        
        //새로운 방뻡 찾기
        print(selectedRow[0][1])
        
        
        nextViewController.jsonData = movieInfos[selectedRow[0][1]]
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// cell layout
// 보기 쉽도록 extension을 사용하여 설정
extension CollectionViewController: UICollectionViewDelegateFlowLayout {

    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 2 - 12 ///  2등분하여 배치, 옆 간격이 12이므로 12를 빼줌
        print("collectionView width=\(collectionView.frame.width)")
        print("cell하나당 width=\(width)")
        print("root view width = \(self.view.frame.width)")

        let size = CGSize(width: width, height: width * 1.8)
        return size
    }
    
    //cell 화면 사이드와 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}
