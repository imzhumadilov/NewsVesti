//
//  UIViewController+identifier.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    public class var identifier: String {
        return String.className(self)
    }
}
