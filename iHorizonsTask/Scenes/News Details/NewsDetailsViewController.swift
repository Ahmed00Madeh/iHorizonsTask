//
//  NewsDetailsViewController.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 17/12/2021.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var newsDateLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsContentLabel: UILabel!
    @IBOutlet weak var newsSourceLabel: UILabel!
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    // MARK: - Variables
    let news: NewsModel
    
    // MARK: - Life Cycle
    init(news: NewsModel) {
        self.news = news
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(String(describing: type(of: self)) + "  Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions
    func setupView() {
        title = "News Details"
        newsTitleLabel.text = news.title
        newsDateLabel.text = news.publishedAt.string(format: "EEE, dd MMM yyyy")
        newsAuthorLabel.text = news.author
        newsDescriptionLabel.text = news.desc
        newsContentLabel.text = news.content
        newsSourceLabel.text = news.sourceName
        guard let url = URL(string: news.image) else { return }
        newsImageView.kf.indicatorType = .activity
        newsImageView.kf.setImage(with: url)
    }
    
    // MARK: - Actions
    @IBAction func goToSiteClicked(_ sender: UIButton) {
        guard let url = URL(string: news.url), UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:])
    }

}
