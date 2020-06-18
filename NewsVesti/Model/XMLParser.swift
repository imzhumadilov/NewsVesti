//
//  XMLParser.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 18.06.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct Image {
    let url: String
    let width: String
    let height: String
}

struct Item {
    let title: String
    let pubDate: String
    let category: String
    let image: Image?
    let content: String
}

class ParserXML: NSObject {
    
    private var items = [Item]()
    private var currentElement = ""
    private var flag = false
    private var image: Image?
    private var title: String = ""
    private var pubDate: String = ""
    private var category: String = ""
    private var content: String = ""
    private var parserCompletionHandler: (([Item]) -> Void)?
    
    func parseData(url: String, completionHandler: (([Item]) -> Void)?) {
        
        self.parserCompletionHandler = completionHandler
        
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }.resume()
    }
}

extension ParserXML: XMLParserDelegate {
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        currentElement = elementName
        if currentElement == "item" {
            title = ""
            pubDate = ""
            category = ""
            image = nil
            content = ""
            flag = true
        }
        
        if elementName == "enclosure",
            flag,
            let picURL = attributeDict["url"],
            let width = attributeDict["width"],
            let height = attributeDict["height"] {
            image = Image(url: picURL, width: width, height: height)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        switch currentElement {
        case "title": title += string
        case "pubDate": pubDate += string
        case "category": category += string
        case "yandex:full-text": content += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item" {
            
            title = title.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            pubDate = pubDate.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            category = category.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            content = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            let dateEng = DateFormatter()
            dateEng.dateFormat = "E, d MMM yyy HH:mm:ss Z"
            let dateRus = DateFormatter()
            dateRus.dateFormat = "d MMM, HH:mm"
            dateRus.locale = Locale(identifier: "ru_Ru")
            if let date = dateEng.date(from: pubDate) {
                pubDate = dateRus.string(from: date)
            }
            
            let item = Item(title: title, pubDate: pubDate, category: category, image: image, content: content)
            items.append(item)
            flag = false
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserCompletionHandler?(items)
    }
}
