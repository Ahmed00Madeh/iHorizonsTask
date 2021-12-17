//
//  NewsModel.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 17/12/2021.
//

import ObjectMapper

class NewsModel: Mappable {

    var sourceName = ""
    var author = ""
    var title = ""
    var desc = ""
    var url = ""
    var image = ""
    var publishedAt = Date()
    var content = ""
    
    required init?(map: Map) {}
    init() { }
    
    func mapping(map: Map) {
        sourceName <- map["source.name"]
        author <- map[""]
        title <- map["title"]
        desc <- map["description"]
        url <- map["url"]
        image <- map["urlToImage"]
        publishedAt <- (map["publishedAt"], StringDateTransform())
        content <- map["content"]
    }
    
}
