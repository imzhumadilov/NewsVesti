//
//  CategoriesTableViewController.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 18.06.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class CategoriesTableViewController: UITableViewController {
    
    var categories = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = categories[indexPath.row].name
        toggleMark(cell, isMarked: categories[indexPath.row].flag)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        
        categories[indexPath.row].flag = !categories[indexPath.row].flag
        toggleMark(cell, isMarked: categories[indexPath.row].flag)
    }
    
    func toggleMark(_ cell: UITableViewCell, isMarked: Bool) {
        cell.accessoryType = isMarked ? .checkmark : .none
    }
    
    func saveNewCategories() -> [Categories] {
        return categories
    }
}
