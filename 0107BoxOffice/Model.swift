//
//  Model.swift
//  0107BoxOffice
//
//  Created by jh on 2021/01/11.
//

import Foundation


struct APIMoviesResponse: Codable {
    let movies: [MovieInfo]
}

struct APIDetailMoviesResponse: Codable {
    let detailMovies: MovieDetail
}

struct APICommentMoviesResponse: Codable {
    let comments: [Comment]
}

//struct APICommentRequest {
//    let commentRequest: commentRequest
//}

struct APICommentResponse: Codable {
    let commentResponse: commentResponse
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
        
        var gradeRatingRate: String {
            return "\(self.reservationGrade)위(\(self.userRating)) / \(self.reservationRate)%"
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

struct MovieDetail: Codable {
    let audience: Int
    let actor: String
    let duration: Int
    let director: String
    let synopsis: String
    let genre: String
    let grade: Int
    let image: String
    let reservationGrade: Int
    let title: String
    let reservationRate: Double
    let userRating: Double
    let date: String
    let id: String
    
    
    var reservationGradeString: String {
        return String(self.reservationGrade) + "위 " + String(self.reservationRate)+"%"
    }
    
    var userRatingImageCount: Int {
        return Int(userRating)
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
        case audience, actor, duration, director, synopsis, genre, grade, image, title, date, id
        case reservationGrade = "reservation_grade"
        case reservationRate = "reservation_rate"
        case userRating = "user_rating"
    }
}

struct Comment: Codable {
    
//    struct Movie: Codable {
        let id: String
        let rating: Double
        let timestamp: Double
        let writer: String
        let movieId: String
        let contents: String
    
    var writeDate: String {
        let date = Date(timeIntervalSince1970: timestamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let StringDate = dateFormatter.string(from: date)
        return StringDate
    }
//        var full: String {
//            return "평점 : " + String(self.userRating) + " 예매순위 : " + String(self.reservationGrade) + " 예매율 : " + String(self.reservationRate)
//        }
        
        
        enum CodingKeys: String, CodingKey {
            case id, rating, timestamp, writer, contents
            case movieId = "movie_id"
        }
}

struct commentRequest {
    var rating: Double
    var writer: String
    var movie_id: String
    var contents: String
    
    
    
    enum CodingKeys: String, CodingKey {
        case rating, writer, movie_id, contents
    }
}

struct commentResponse: Codable {
    let rating: Double
    let timestamp: Double
    let writer: String
    let movieId: String
    let contents: String
    
    
    
    enum CodingKeys: String, CodingKey {
        case rating, writer, timestamp, contents
        case movieId = "movie_id"
    }
}


