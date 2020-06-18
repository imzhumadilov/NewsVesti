//
//  FullNewsViewController.swift
//  NewsVesti
//
//  Created by Ilyas Zhumadilov on 18.06.2020.
//  Copyright © 2020 Ilyas Zhumadilov. All rights reserved.
//

import UIKit

class FullNewsViewController: UIViewController {
    
    var news: Item?
    var scrollView = UIScrollView()
    var imageView = UIImageView()
    var name = UILabel()
    var content = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showData()
    }
    
    private func showData() {
        
        guard let item = news else { return }
        
        scrollView = UIScrollView(frame: view.bounds)
        let widthView = view.frame.width
        let constantX: CGFloat = 8
        
        let heightImage = getImage(item: item, widthImage: widthView)
        
        let fontForTitle = UIFont.systemFont(ofSize: 20)
        let widthTitle = widthView - 2 * constantX
        let heightTitle = item.title.height(width: widthTitle, font: fontForTitle)
        let yTitle = heightImage + 20
        let title = CGRect(x: constantX, y: yTitle, width: widthTitle, height: heightTitle)
        
        name = UILabel(frame: title)
        name.textAlignment = .center
        name.textColor = .brown
        name.font = fontForTitle
        name.numberOfLines = 0
        name.text = item.title
        scrollView.addSubview(name)
        
        let fontForContent = UIFont.systemFont(ofSize: 16)
        let widthPost = widthView - 2 * constantX
        let heightPost = item.content.height(width: widthPost, font: fontForContent)
        let yPost = title.origin.y + title.size.height + 8
        let post = CGRect(x: constantX, y: yPost, width: widthPost, height: heightPost)
        
        content = UILabel(frame: post)
        content.font = fontForContent
        content.numberOfLines = 0
        content.text = item.content
        scrollView.addSubview(content)
        
        let heightSV = post.origin.y + post.size.height + 20
        scrollView.contentSize = CGSize(width: widthView, height: heightSV)
        view.addSubview(scrollView)
    }
    
    private func getImage(item: Item, widthImage: CGFloat) -> CGFloat {
        
        var heightImage: CGFloat = 0
        
        guard let imageNews = item.image,
            let url = URL(string: imageNews.url),
            let widthPic = Int(imageNews.width),
            let heightPic = Int(imageNews.height) else { return heightImage }
        
        let ratio = CGFloat(widthPic) / CGFloat(heightPic)
        heightImage = widthImage / ratio
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: widthImage, height: heightImage))
        imageView.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }.resume()
        
        return heightImage
    }
}
