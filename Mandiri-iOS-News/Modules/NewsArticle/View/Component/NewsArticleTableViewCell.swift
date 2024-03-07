//
//  NewsArticleTableViewCell.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import UIKit
import SDWebImage

class NewsArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsImageView: UIImageView!
    
    static let identifier = "NewsArticleTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    
    func config(newsArticle: NewsArticleModel) {
        newsTitle.text = newsArticle.title
        newsContent.text = newsArticle.description ?? ""
        newsImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        newsImageView.sd_imageIndicator?.startAnimatingIndicator()
        
        let placeholderImage = UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        newsImageView.sd_setImage(
            with: URL(string: newsArticle.urlToImage ?? ""),
            placeholderImage: placeholderImage) { [weak self] _, _, _, _ in
                self?.newsImageView.sd_imageIndicator?.stopAnimatingIndicator()
            }
        
    }
    
}
