//
//  NewsService.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

class NewsService: NSObject {
    
    private var news = [News]()
    private var currentElement = ""
    private var parserCompletionHandler: ((Result<[News], Error>) -> Void)?
    private var pieceOfNews = News()
    
    public func getNews(url: String, completionHandler: ((Result<[News], Error>) -> Void)?) {
        
        parserCompletionHandler = completionHandler
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler?(.failure(error))
                }
                return
            }
            
            guard let data = data else { return }
            
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
            
        }.resume()
    }
}

extension NewsService: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" {
            pieceOfNews = News()
        }
        
        if elementName == "enclosure" {
            pieceOfNews.imageUrl = attributeDict["url"] ?? ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title": pieceOfNews.title += string
        case "pubDate": pieceOfNews.pubDate += string
        case "category": pieceOfNews.category += string
        case "yandex:full-text": pieceOfNews.content += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            
            pieceOfNews.title = pieceOfNews.title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            pieceOfNews.pubDate = pieceOfNews.pubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            pieceOfNews.category = pieceOfNews.category.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            pieceOfNews.content = pieceOfNews.content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            news.append(pieceOfNews)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.async {
            self.parserCompletionHandler?(.success(self.news))
        }
    }
}
