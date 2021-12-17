//
//  PagedModel.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 16/12/2021.
//

import ObjectMapper

class PagedModel<T: Mappable>: Mappable {
    
    var totalResults = 0
    var result: [T] = []
    
    var nextPage: Int {
        return Int(result.count / 20) + 1
    }
        
    required init?(map: Map) {}
    init() { }
    
    func hasNext(_ indexPath: IndexPath) -> Bool {
        return result.count < totalResults && indexPath.row == result.count - 1
    }
    
    func mapping(map: Map) {
        totalResults <- map["totalResults"]
        result <- map["articles"]
    }
}
