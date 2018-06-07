//
//  RSSFeedItem+Additions.swift
//  Enrollee
//
//  Created by Денис Бородавченко on 19.03.2018.
//  Copyright © 2018 Денис Бородавченко. All rights reserved.
//

import Foundation
import FeedKit
import HTMLEntities

extension RSSFeed {
    func getDict() -> [[String : String]]? {
        var json = [[String : String]]()
        guard let path = image?.url else {
            return nil
        }
        for item in items! {
            let dict = ["title" : item.title,
                        "description": item.description?.htmlUnescape(),
                        "link" : item.link,
                        "img_url" : path]
            json.append(dict as! [String : String])
        }
        return json
    }
}
