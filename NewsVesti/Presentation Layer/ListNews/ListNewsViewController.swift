//
//  ListNewsViewController.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

final class ListNewsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    var viewModel: ListNewsViewModel?
    var router: ListNewsRouterInput?
    private var news = [News]()
    private var categories = [Categories]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponents()
        bindViewModel()
        viewModel?.loadData()
    }
    
    // MARK: - Setup functions
    private func setupComponents() {
        navigationItem.title = "News"
        let rightBarButton = UIBarButtonItem(title: "Categories", style: .plain, target: self, action: #selector(rightBarButtonTapped))
        navigationItem.setRightBarButton(rightBarButton, animated: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: DescriptionCell.id, bundle: nil),
                           forCellReuseIdentifier: DescriptionCell.id)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(updateNews), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // MARK: - Module functions
    private func bindViewModel() {
        
        viewModel?.loadDataCompletion = { [weak self] result in
            
            switch result {
                
            case .success(let data):
                self?.news = data.news
                self?.categories = data.categories
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Actions
    @objc
    private func updateNews(sender: UIRefreshControl) {
        viewModel?.loadData()
        sender.endRefreshing()
    }
    
    @objc
    private func rightBarButtonTapped() {
        router?.presentCategories(with: categories)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ListNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: DescriptionCell.id,
                                 for: indexPath) as? DescriptionCell else { return UITableViewCell() }
        
        let pieceOfNews = news[indexPath.row]
        cell.setup(title: pieceOfNews.title, date: pieceOfNews.pubDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.presentInfoNews(with: news[indexPath.row])
    }
}
