//
//  InfoNewsConfigurator.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

enum InfoNewsConfigurator {
    
    static func create() -> InfoNewsViewController {
        return InfoNewsViewController(nibName: InfoNewsViewController.identifier, bundle: nil)
    }
    
    @discardableResult
    static func configure(with reference: InfoNewsViewController) -> InfoNewsViewModelInput {
        let viewModel = InfoNewsViewModel()
        
        reference.viewModel = viewModel
        
        return viewModel
    }
}
