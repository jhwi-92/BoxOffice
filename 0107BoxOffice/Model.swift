//
//  Model.swift
//  0107BoxOffice
//
//  Created by jh on 2021/01/11.
//

import Foundation


struct APIResponse: Codable {
    let movies: [MovieInfo]
}

struct MovieInfo: Codable {
    
//    struct Movie: Codable {
        let grade: Int
        let thumb: String
        let reservationGrade: Int
        let title: String
        let reservationRate: Double
        let userRating: Double
        let date: String
        let id: String
    
        var full: String {
            return "평점 : " + String(self.userRating) + " 예매순위 : " + String(self.reservationGrade) + " 예매율 : " + String(self.reservationRate)
        }
        var ageImageName: String {
            switch grade {
            case 12, 15, 19:
                return "ic_"+String(grade)
            default:
                return "ic_allages"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case grade, thumb, title, date, id
            case reservationGrade = "reservation_grade"
            case reservationRate = "reservation_rate"
            case userRating = "user_rating"
        }
//    }
    
//    let movies: Movie
    //let orderType: Int
    
//    enum CodingKeys: String, CodingKey {
//        case movies
//        //case orderType = "order_type"
//    }
    
    
}


