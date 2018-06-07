//
//  NewsService.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import FeedKit
import SwiftyJSON
import ObjectMapper

class NewsService {
    static let shared = NewsService()
    private var rssPath: URL! {
        return URL(string: "http://volpi.ru/volpinews.rss")
    }
    
    private init() { }
    
    func parseNews(completion: @escaping(_ news: [News]?, _ error: NSError?) -> Void) {
        let parser = FeedParser(URL: rssPath)
        if parser == nil {
            let error = NSError(domain: "Enrollee", code: 1488, userInfo: ["description":"pizda RSS'y"])
            completion(nil, error)
        }
        parser?.parseAsync(result: { (result) in
            guard !result.isFailure else {
                completion(nil, result.error)
                return
            }
            guard let rssFeed = result.rssFeed else {
                print("Cannot parse RSS")
                return
            }
            guard let json = rssFeed.getDict() else {
                return
            }
            let news = Mapper<News>().mapArray(JSONArray: json)
            completion(news, nil)
        })
    }
}
