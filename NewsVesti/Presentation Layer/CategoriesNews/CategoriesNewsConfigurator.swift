//
//  CategoriesNewsConfigurator.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

enum CategoriesNewsConfigurator {
    
    static func create() -> CategoriesNewsViewController {
        return CategoriesNewsViewController(nibName: CategoriesNewsViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: CategoriesNewsViewController) -> CategoriesNewsViewModelInput {
        let viewModel = CategoriesNewsViewModel()
        
        let router = CategoriesNewsRouter()
        router.viewController = reference
        
        reference.router = router
        reference.viewModel = viewModel
        
        return viewModel
    }
}
