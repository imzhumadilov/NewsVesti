//
//  CategoriesNewsViewModel.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

protocol CategoriesNewsViewModelInput {
    func configure(with categories: [Categories])
}

protocol CategoriesNewsViewModelDelegate: AnyObject {
    func updateCategories(with categories: [Categories])
}

class CategoriesNewsViewModel {
    
    // MARK: - Props
    var loadDataCompletion: ((Result<[Categories], Error>) -> Void)?
    private var categories = [Categories]()
    weak var delegate: CategoriesNewsViewModelDelegate?
    
    // MARK: - Public functions
    public func loadData() {
        loadDataCompletion?(.success(categories))
    }
}

// MARK: - CategoriesViewModelInput
extension CategoriesNewsViewModel: CategoriesNewsViewModelInput {
    
    func configure(with categories: [Categories]) {
        self.categories = categories
    }
}
