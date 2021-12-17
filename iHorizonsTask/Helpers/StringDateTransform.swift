//
//  StringDateTransform.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 16/12/2021.
//

import ObjectMapper

struct StringDateTransform: TransformType {
    
    typealias Object = Date
    typealias JSON = String
    var dateFormat: String = "yyyy-MM-dd'T'HH:mm:ssZ"
    func transformFromJSON(_ value: Any?) -> Date? {
        guard let string = value as? String else { return .none }
        let formatter = DateFormatter.init(withFormat: dateFormat, locale: "en")
        return formatter.date(from: string)
        
    }
    
    func transformToJSON(_ value: Date?) -> String? {
        return value?.string(format: dateFormat, identifier: .gregorian)
    }
}
