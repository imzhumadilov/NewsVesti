//
//  InfoNewsViewController.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

final class InfoNewsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Props
    var viewModel: InfoNewsViewModel?
    var router: InfoNewsRouterInput?
    private var news: News?
    
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: ImageCell.id, bundle: nil),
                           forCellReuseIdentifier: ImageCell.id)
        tableView.register(UINib(nibName: InformationCell.id, bundle: nil),
                           forCellReuseIdentifier: InformationCell.id)
    }
    
    // MARK: - Module functions
    private func bindViewModel() {
        
        viewModel?.loadDataCompletion = { [weak self] result in
            
            switch result {
                
            case .success(let news):
                self?.news = news
                self?.tableView.reloadData()
                
            case .failure:
                break
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension InfoNewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
            
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: ImageCell.id,
                                     for: indexPath) as? ImageCell,
                let news = news else { return UITableViewCell() }
            
            cell.setup(imageURL: news.imageUrl)
            return cell
            
        case 1:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: InformationCell.id,
                                     for: indexPath) as? InformationCell,
                let news = news else { return UITableViewCell() }
            
            cell.setup(name: news.title, info: news.content)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
