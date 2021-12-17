//
//  API.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 16/12/2021.
//

import ESNetworkManager
import Alamofire
import PromiseKit

class API: NSObject {

    static func getNews(query: String, pageNumber: Int) -> Promise<PagedModel<NewsModel>> {
        let request = ESNetworkRequest(base: Constants.baseUrl, path: "everything")
        request.encoding = URLEncoding.default
        request.parameters = ["q": query,
                              "apiKey": Constants.apiKey,
                              "page": pageNumber]
        return ESNetworkManager.execute(request: request)
    }
    
}
