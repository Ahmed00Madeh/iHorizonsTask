//
//  NewsTableViewCell.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 17/12/2021.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    
    // MARK: - Variables
    var news: NewsModel! {
        didSet {
            newsTitleLabel.text = news.title
            newsSourceLabel.text = news.sourceName
            guard let url = URL(string: news.image) else { return }
            newsImageView.kf.indicatorType = .activity
            newsImageView.kf.setImage(with: url)
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    // MARK: - Functions
    
}
