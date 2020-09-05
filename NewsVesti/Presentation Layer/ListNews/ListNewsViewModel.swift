//
//  ListNewsViewModel.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

protocol ListNewsViewModelInput {
    func configure(with data: Any?)
}

class ListNewsViewModel {
    
    // MARK: - Props
    var loadDataCompletion: ((Result<(news: [News], categories: [Categories]), Error>) -> Void)?
    private let newsService = NewsService()
    private var news = [News]()
    private var categories = [Categories]()
    
    // MARK: - Public functions
    public func loadData() {
        
        newsService.getNews(url: Routing.News.dataXML) { (result) in
            
            switch result {
                
            case .success(let news):
                var categoriesSet = Set<Categories>()
                
                news.forEach {
                    $0.updatePubDate()
                    categoriesSet.insert(Categories(name: $0.category, isSelected: true))
                }
                
                self.news = news
                self.categories = categoriesSet.sorted(by: { $0.name > $1.name })
                self.loadDataCompletion?(.success((news, self.categories)))
                
            case .failure(let error):
                self.loadDataCompletion?(.failure(error))
            }
        }
    }
}

// MARK: - ListNewsViewModelInput
extension ListNewsViewModel: ListNewsViewModelInput {
    func configure(with data: Any?) { }
}

// MARK: - CategoriesViewModelDelegate
extension ListNewsViewModel: CategoriesNewsViewModelDelegate {
    
    func updateCategories(with categories: [Categories]) {
        
        self.categories = categories
        
        let filteredCategories = categories.filter { $0.isSelected == true }
        var filteredNews = [News]()
        
        for pieceOfNews in news {
            for category in filteredCategories {
                if category.name == pieceOfNews.category {
                    filteredNews.append(pieceOfNews)
                }
            }
        }
        
        loadDataCompletion?(.success((filteredNews, categories)))
    }
}
