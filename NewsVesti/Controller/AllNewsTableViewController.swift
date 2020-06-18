//
//  AllNewsTableViewController.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 18.06.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class AllNewsTableViewController: UITableViewController {
    
    var items = [Item]()
    var itemsFiltered = [Item]()
    var categories = [Categories]()
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        myRefreshControl.addTarget(self, action: #selector(updateNews), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc private func updateNews(sender: UIRefreshControl) {
        fetchData()
        sender.endRefreshing()
    }
    
    private func fetchData() {
        ParserXML().parseData(url: "https://www.vesti.ru/vesti.rss") { (items) in
            DispatchQueue.main.async {
                self.items = items
                self.updateCategories()
                self.updateData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsFiltered.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AllNewsTableViewCell
        cell.title.text = itemsFiltered[indexPath.row].title
        cell.date.text = itemsFiltered[indexPath.row].pubDate
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNews" {
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let news = itemsFiltered[indexPath.row]
            let newsVC = segue.destination as! FullNewsViewController
            newsVC.news = news
            
        } else if segue.identifier == "showCategories" {
            
            let categoriesVC = segue.destination as! CategoriesTableViewController
            categoriesVC.categories = categories
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = tableView.frame.size.width - 2 * 8
        let heightT = itemsFiltered[indexPath.row].title.height(width: width, font: UIFont.systemFont(ofSize: 20))
        let heightD = itemsFiltered[indexPath.row].pubDate.height(width: width, font: UIFont.systemFont(ofSize: 16))
        
        return heightT + heightD + 3 * 8
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "showNews", sender: nil)
    }
    
    @IBAction func unwindSegueSave(_ segue: UIStoryboardSegue) {
        
        guard let categoriesVC = segue.source as? CategoriesTableViewController else { return }
        categories = categoriesVC.saveNewCategories()
        updateData()
    }
    
    private func updateCategories() {
        
        var set = Set<Categories>()
        
        for i in 0..<items.count {
            set.insert(Categories(name: items[i].category, flag: true))
        }
        
        if categories.count == 0 {
            categories = set.shuffled()
            
        } else {
            var categoriesNew = set.shuffled()
            
            var categoriesOld = [String]()
            for i in 0..<categories.count {
                categoriesOld.append(categories[i].name)
            }
            
            for i in 0..<categoriesNew.count {
                let flag = categoriesOld.contains(categoriesNew[i].name)
                if !flag {
                    categoriesNew[i].flag = false
                    categories.append(categoriesNew[i])
                }
            }
        }
    }
    
    private func updateData() {
        
        itemsFiltered.removeAll()
        let categoriesMarked = categories.filter({ $0.flag == true })
        for i in 0..<items.count {
            for j in 0..<categoriesMarked.count {
                if items[i].category == categoriesMarked[j].name {
                    itemsFiltered.append(items[i])
                }
            }
        }
        tableView.reloadData()
    }
}
