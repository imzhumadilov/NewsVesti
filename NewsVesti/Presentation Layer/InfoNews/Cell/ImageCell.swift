//
//  ImageCell.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 05.09.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var avatarImageView: UIImageView!
    
    // MARK: - Props
    static let id = String(describing: ImageCell.self)
    
    // MARK: - Setup functions
    public func setup(imageURL: String) {
        
        guard let imageURL = URL(string: imageURL) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { [weak self] (data, response, error) in
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.avatarImageView.image = image
            }
        }.resume()
    }
}
