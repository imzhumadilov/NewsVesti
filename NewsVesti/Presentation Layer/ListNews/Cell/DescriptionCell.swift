//
//  DescriptionCell.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Props
    static let id = String(describing: DescriptionCell.self)
    
    // MARK: - Setup functions
    public func setup(title: String, date: String) {
        titleLabel.text = title
        dateLabel.text = date
    }
}
