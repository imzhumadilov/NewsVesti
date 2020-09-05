//
//  News.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

class News {
    
    var title: String
    var pubDate: String
    var category: String
    var imageUrl: String
    var content: String
    
    init() {
        self.title = ""
        self.pubDate = ""
        self.category = ""
        self.imageUrl = ""
        self.content = ""
    }
    
    public func updatePubDate() {
        
        let dateFormatterOld = DateFormatter()
        dateFormatterOld.dateFormat = "E, d MMM yyy HH:mm:ss Z"
        
        let dateFormatterNew = DateFormatter()
        dateFormatterNew.dateFormat = "d MMM, HH:mm"
        
        dateFormatterNew.locale = Locale(identifier: "ru_Ru")
        
        if let date = dateFormatterOld.date(from: pubDate) {
            self.pubDate = dateFormatterNew.string(from: date)
        }
    }
}
