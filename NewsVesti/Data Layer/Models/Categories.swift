//
//  Categories.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation

struct Categories: Hashable {
    
    let name: String
    var isSelected: Bool
    
    init(name: String, isSelected: Bool) {
        self.name = name
        self.isSelected = isSelected
    }
}
