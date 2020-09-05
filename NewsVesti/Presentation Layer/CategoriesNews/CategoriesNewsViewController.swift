//
//  CategoriesNewsViewController.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

final class CategoriesNewsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    var viewModel: CategoriesNewsViewModel?
    var router: CategoriesNewsRouterInput?
    private var categories = [Categories]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        bindViewModel()
        viewModel?.loadData()
    }
    
    // MARK: - Setup functions
    private func setupComponents() {
        navigationItem.title = "Categories"
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: CategoryCell.id, bundle: nil),
                           forCellReuseIdentifier: CategoryCell.id)
    }
    
    // MARK: - Module functions
    private func bindViewModel() {
        
        viewModel?.loadDataCompletion = { [weak self] result in
            
            switch result {
                
            case .success(let categories):
                self?.categories = categories
                
            case .failure:
                break
            }
        }
    }
    
    // MARK: - Actions
    @objc
    private func rightBarButtonTapped() {
        viewModel?.delegate?.updateCategories(with: categories)
        router?.dismiss()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CategoriesNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: CategoryCell.id,
                                 for: indexPath) as? CategoryCell else { return UITableViewCell() }
        
        let category = categories[indexPath.row]
        cell.setup(category: category)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        categories[indexPath.row].isSelected = !categories[indexPath.row].isSelected
        cell.accessoryType = categories[indexPath.row].isSelected ? .checkmark : .none
    }
}

