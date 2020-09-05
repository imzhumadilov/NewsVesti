//
//  ListNewsConfigurator.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

enum ListNewsConfigurator {
    
    static func create() -> ListNewsViewController {
        return ListNewsViewController(nibName: ListNewsViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: ListNewsViewController) -> ListNewsViewModelInput {
        let viewModel = ListNewsViewModel()
        
        let router = ListNewsRouter()
        router.viewController = reference
        
        reference.router = router
        reference.viewModel = viewModel
        
        return viewModel
    }
}
