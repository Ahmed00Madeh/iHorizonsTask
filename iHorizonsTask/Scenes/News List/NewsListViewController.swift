//
//  NewsListViewController.swift
//  iHorizonsTask
//
//  Created by Ahmed Madeh on 17/12/2021.
//

import UIKit

class NewsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Variables
    let activityIndicatorView = UIActivityIndicatorView(frame: .init(x: 0, y: 0, width: 40, height: 40))
    lazy var placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search keyword"
        label.textAlignment = .center
        return label
    }()
    var model = PagedModel<NewsModel>()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Functions
    func setupView() {
        title = "News"
        activityIndicatorView.style = .large
        tableView.registerCell(ofType: NewsTableViewCell.self)
        tableView.backgroundView  = placeholderLabel
        tableView.tableFooterView = activityIndicatorView
        searchBar.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        searchNews(searchKey: "")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
    @objc func searchNews(searchKey: String) {
        activityIndicatorView.startAnimating()
        
        API.getNews(query: searchKey, pageNumber: model.nextPage).done { [weak self] response in
            guard let self = self else { return }
            self.model.result.append(contentsOf: response.result)
            self.model.totalResults = response.totalResults
            self.placeholderLabel.isHidden = response.totalResults != 0
            self.tableView.reloadData()
        }.catch { [weak self] error in
            guard let self = self else { return }
            self.showAlert(with: error.localizedDescription)
        }.finally {
            self.activityIndicatorView.stopAnimating()
        }
    }
    
    func showAlert(with error: String) {
        let alert = UIAlertController.init(title: error, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    @objc
    func textFieldEditingChanged(_ sender: UITextField)  {
        model.result.removeAll()
        tableView.reloadData()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(searchNews(searchKey:)), object: nil)
        self.perform(#selector(searchNews(searchKey:)), with: sender.text, afterDelay: 0.7)
    }
    
    // MARK: - Actions

}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NewsTableViewCell = tableView.dequeueReusableCell()!
        cell.news = model.result[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(NewsDetailsViewController(news: model.result[indexPath.row]), animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if model.hasNext(indexPath) {
            searchNews(searchKey: searchBar.text!)
        }
    }
    
    
}
