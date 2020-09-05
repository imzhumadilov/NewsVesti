//
//  ListNewsRouter.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

protocol ListNewsRouterInput {
    func presentInfoNews(with news: News)
    func presentCategories(with categories: [Categories])
}

final class ListNewsRouter: ListNewsRouterInput {
    
    // MARK: - Props
    weak var viewController: ListNewsViewController?
    
    // MARK: - ListNewsRouterInput
    func presentInfoNews(with news: News) {
        let vc = InfoNewsConfigurator.create()
        let infoNewsInput = InfoNewsConfigurator.configure(with: vc)
        infoNewsInput.configure(with: news)
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func presentCategories(with categories: [Categories]) {
        let vc = CategoriesNewsConfigurator.create()
        let infoNewsInput = CategoriesNewsConfigurator.configure(with: vc)
        vc.viewModel?.delegate = viewController?.viewModel
        infoNewsInput.configure(with: categories)
        
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
