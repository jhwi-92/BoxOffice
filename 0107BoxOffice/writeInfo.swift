//
//  writeInfo.swift
//  0107BoxOffice
//
//  Created by jh on 2021/03/31.
//
//싱글톤(데이터를 저장해두기 위해서 사용)
import Foundation


class WriteInfo {
    
    static let shared: WriteInfo = WriteInfo()
    
    private init() {}
    
    var rating: Double?
    var writer: String?
    var movieId: String?
    var contents: String?
    
}

class Setting {
    
    static let shared: Setting = Setting()
    
    private init() {}
    
    var orderType: String?
    
    
}
