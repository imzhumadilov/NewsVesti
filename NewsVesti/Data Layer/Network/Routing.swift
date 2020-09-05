//
//  Routing.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

enum Routing {
    
    enum UrlPaths {
        static let newsServiceURL = "https://www.vesti.ru"
    }
    
    enum News {
        static let dataXML = Routing.UrlPaths.newsServiceURL + "/vesti.rss"
    }
}
