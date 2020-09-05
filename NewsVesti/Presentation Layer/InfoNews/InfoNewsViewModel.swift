//
//  InfoNewsViewModel.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

protocol InfoNewsViewModelInput {
    func configure(with news: News)
}

class InfoNewsViewModel {
    
    // MARK: - Props
    private var news: News?
    var loadDataCompletion: ((Result<News, Error>) -> Void)?
    
    // MARK: - Public functions
    public func loadData() {
        
        guard let news = news else { return }
        
        loadDataCompletion?(.success(news))
    }
}

// MARK: - InfoNewsViewModelInput
extension InfoNewsViewModel: InfoNewsViewModelInput {
    
    func configure(with news: News) {
        self.news = news
    }
}

