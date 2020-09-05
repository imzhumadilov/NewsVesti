//
//  InformationCell.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class InformationCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    
    // MARK: - Props
    static let id = String(describing: InformationCell.self)
    
    // MARK: - Setup functions
    public func setup(name: String, info: String) {
        nameLabel.text = name
        infoLabel.text = info
    }
}
