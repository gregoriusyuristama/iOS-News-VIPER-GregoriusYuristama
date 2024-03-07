//
//  NewsArticleViewController.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import UIKit

protocol NewsArticleViewProtocol {
    var presenter: NewsArticlePresenterProtocol? { get set }
    
    func update(with newsArticles: [NewsArticleModel])
    func update(with newsArticles: Error)
}

class NewsArticleViewController: UIViewController, NewsArticleViewProtocol {
    var presenter: NewsArticlePresenterProtocol?
    var spinner = UIActivityIndicatorView()
    var searchController = UISearchController(searchResultsController: nil)
    
    lazy var newsArticles: [NewsArticleModel] = []
    private var fetcherNewsArticles: [NewsArticleModel] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NewsArticleTableViewCell.nib(), forCellReuseIdentifier: NewsArticleTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    
    func update(with newsArticles: [NewsArticleModel]) {
        DispatchQueue.main.async {
            self.newsArticles = newsArticles
            print(newsArticles)
            self.fetcherNewsArticles = newsArticles
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async {
            print(error)
            self.newsArticles = []
            self.tableView.isHidden = true
            self.label.text = error.localizedDescription
            self.label.isHidden = false
            self.spinner.stopAnimating()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    deinit {
        self.newsArticles = []
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchController.searchResultsUpdater = self
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search News Article"
    }
    
}

extension NewsArticleViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsArticleTableViewCell.identifier, for: indexPath) as? NewsArticleTableViewCell else { return UITableViewCell() }
        cell.config(newsArticle: newsArticles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showNewsWebView(news: newsArticles[indexPath.row])
    }
}

extension NewsArticleViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.async {
            if let searchText = searchController.searchBar.text {
                if !searchText.isEmpty {
                    self.newsArticles = self.fetcherNewsArticles.filter({$0.title.localizedStandardContains(searchText)})
                    self.tableView.reloadData()
                } else {
                    self.newsArticles = self.fetcherNewsArticles
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
}
