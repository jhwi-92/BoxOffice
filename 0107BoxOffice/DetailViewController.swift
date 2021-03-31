//
//  DetailViewController.swift
//  0107BoxOffice
//
//  Created by jh on 2021/02/02.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var jsonData: MovieInfo?
    var detailMovies: MovieDetail?
    var comments: [Comment] = []
    @IBOutlet weak var tableView: UITableView!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 1
        } else if section == 2 {
            return self.comments.count
        } else {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "movieInfoCell", for: indexPath)
        
        if indexPath.section == 0 {
            guard let cell: CustomDetailTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "movieInfoCell", for: indexPath) as? CustomDetailTableViewCell else {return CustomDetailTableViewCell()}
            guard detailMovies != nil else {return cell}
            if indexPath.row == 0 {
    //            cell.imageView?.image = UIImage(named: "ic_settings")
                
                
                
                let imageURL: URL = URL(string: detailMovies!.image)!
                print("URL")
                print(imageURL)
                cell.CumulativeAudienceText.text = "누적관객수"
                cell.userRatingText.text = "평점"
                cell.reservationRateText.text = "예매율"
                //cell.CumulativeAudienceText.intrinsicContentSize.width
                //cell.CumulativeAudience.text = self.detailMovies!.
                cell.reservationRate.text = self.detailMovies!.reservationGradeString
                cell.userRating.text = String(self.detailMovies!.userRating)
                let CumulativeAudienceDecimar: String = CustomDecimal(value: self.detailMovies!.audience)
                cell.CumulativeAudience.text = CumulativeAudienceDecimar
                OperationQueue().addOperation {
                    do {
                        let imageData: Data = try Data.init(contentsOf: imageURL)
                        
                        let image: UIImage = UIImage(data: imageData)!
                        

                        OperationQueue.main.addOperation {
                            for i in 0...4{
                                var countImage: UIImageView = cell.oneImage
                                switch i {
                                case 0:
                                    countImage = cell.oneImage
                                    break
                                case 1:
                                    countImage = cell.twoImage
                                    break
                                case 2:
                                    countImage = cell.threeImage
                                    break
                                case 3:
                                    countImage = cell.fourImage
                                    break
                                case 4:
                                    countImage = cell.fiveImage
                                    break
                                default:
                                    break
                                }
                                if self.detailMovies!.userRatingImageCount >= (i + 1) * 2 {
                                    countImage.image = UIImage(named: "ic_star_large_full")
                                } else if self.detailMovies!.userRatingImageCount > i * 2 {
                                    countImage.image = UIImage(named: "ic_star_large_half")
                                } else {
                                    countImage.image = UIImage(named: "ic_star_large")
                                }
                            }
                            //cell.titleLabel.attributedText = attributedString
                            cell.titleLabel.text = self.detailMovies?.title
                            cell.dateLabel.text = self.detailMovies!.date+"개봉"
                            cell.detailLabel.text = self.detailMovies!.genre+"/"+String(self.detailMovies!.duration)+"분"
                            cell.titleImage.image = image
                            //cell.gradeImage.attributedText = ratingAttributed
                           
                        }
                        
                    } catch {
                        print("데이터 없음")
                        print(self.detailMovies!.image)
                    }
                }
                return cell
            } else if indexPath.row == 1 {
                guard let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath) as? UITableViewCell else {return UITableViewCell()}
                cell.textLabel?.text = "줄거리"
                cell.detailTextLabel?.text = self.detailMovies!.synopsis
                return cell
            } else if indexPath.row == 2 {
                guard let cell: CustomActorTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as? CustomActorTableViewCell else {return CustomActorTableViewCell()}
                //cell.textLabel?.text = "줄거리"
                //cell.detailTextLabel?.text = self.detailMovies!.synopsis
                cell.actor.text = self.detailMovies!.actor
                cell.director.text = self.detailMovies!.director
                return cell
            }

            
            return cell
        } else if indexPath.section == 1 {
            if indexPath.row == 0 {
                guard let cell: CustomHeaderTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as? CustomHeaderTableViewCell else {return UITableViewCell()}
                
                cell.titleText.text = "한줄평"
                let buttonImage: UIImage = UIImage(named: "btn_compose")!
                cell.outletWhiteButton.setImage(buttonImage, for: UIControl.State.normal)
                
                return cell
            }
            
        } else if indexPath.section == 2 {
            guard let cell: CustomCommentTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CustomCommentTableViewCell else {return UITableViewCell()}
            
            cell.userImage.image = UIImage(named: "ic_user_loading")
            cell.userName.text = self.comments[indexPath.row].writer
            cell.userDate.text = self.comments[indexPath.row].writeDate
            cell.userComment.text = self.comments[indexPath.row].contents
            
            OperationQueue.main.addOperation {
                for i in 0...4{
                    var countImage: UIImageView = cell.oneImage
                    switch i {
                    case 0:
                        countImage = cell.oneImage
                        break
                    case 1:
                        countImage = cell.twoImage
                        break
                    case 2:
                        countImage = cell.threeImage
                        break
                    case 3:
                        countImage = cell.fourImage
                        break
                    case 4:
                        countImage = cell.fiveImage
                        break
                    default:
                        break
                    }
                    if Int(self.comments[indexPath.row].rating) >= (i + 1) * 2 {
                        countImage.image = UIImage(named: "ic_star_large_full")
                    } else if Int(self.comments[indexPath.row].rating) > i * 2 {
                        countImage.image = UIImage(named: "ic_star_large_half")
                    } else {
                        countImage.image = UIImage(named: "ic_star_large")
                    }
                }
               
            }
            return cell
        }
        
        return UITableViewCell()
    }
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else if section == 1{
            return 10
        } else if section == 2{
            return 0
        } else {
            return 0
        }
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        if indexPath.section == 2 {
//            return UITableView.automaticDimension
//        } else {
//            return 1
//        }
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dataConnect()
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        dataConnect(getURL: "https://connect-boxoffice.run.goorm.io/movie?id=", getType: "detail")
        dataConnect(getURL: "https://connect-boxoffice.run.goorm.io/comments?movie_id=", getType:  "comment")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func dataConnect(getURL: String, getType: String) {
        guard let url: URL = URL(string: getURL+jsonData!.id) else {return}
        print("url")
        print(url)

        let session: URLSession = URLSession(configuration: .default)
        let dataTask: URLSessionDataTask = session.dataTask(with: url) {(data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {return}

            do {
                if getType == "detail" {
                    let apiResponse: MovieDetail = try JSONDecoder().decode(MovieDetail.self, from: data)
                    self.detailMovies = apiResponse
                    print("ttttttttttttt")
                    print(self.detailMovies!)
                } else if getType == "comment" {
                    let apiResponse: APICommentMoviesResponse = try JSONDecoder().decode(APICommentMoviesResponse.self, from: data)
                    self.comments = apiResponse.comments
                    print("ttttttttttttt")
                    print(self.comments)
                }
                
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }

            } catch(let err) {
                print(err.localizedDescription)
            }

        }
        dataTask.resume()
    }
    
    func CustomDecimal(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))!
            
            return result
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: WriteViewController = segue.destination as? WriteViewController else {
            return
        }
        
//        guard let selectedRow = tableView.indexPathForSelectedRow?.row else {
//            return
//        }
        
        nextViewController.jsonData = self.detailMovies
    }
}
