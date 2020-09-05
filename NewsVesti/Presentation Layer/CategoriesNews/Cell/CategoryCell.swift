//
//  CategoryCell.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    
    // MARK: - Props
    static let id = String(describing: CategoryCell.self)
    
    // MARK: - Setup functions
    public func setup(category: Categories) {
        
        nameLabel.text = category.name
        accessoryType = category.isSelected ? .checkmark : .none
    }
}
