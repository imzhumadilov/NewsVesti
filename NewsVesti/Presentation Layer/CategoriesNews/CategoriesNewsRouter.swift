//
//  CategoriesNewsRouter.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

protocol CategoriesNewsRouterInput {
    func dismiss()
}

final class CategoriesNewsRouter: CategoriesNewsRouterInput {
    
    // MARK: - Props
    weak var viewController: CategoriesNewsViewController?
    
    // MARK: - CategoriesNewsRouterInput
    func dismiss() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
