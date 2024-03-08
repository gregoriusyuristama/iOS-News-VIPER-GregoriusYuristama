//
//  NewsArticleViewController.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import UIKit
import UIScrollView_InfiniteScroll

class NewsArticleViewController: UIViewController, NewsArticleViewProtocol {
    var presenter: NewsArticlePresenterProtocol?
    var spinner = UIActivityIndicatorView()
    var searchController = UISearchController(searchResultsController: nil)
    
    lazy var newsArticles: [NewsArticleModel] = []
    private var displayedNewsArticle: [NewsArticleModel] = []
    
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
    
    
    func update(with newsArticles: [NewsArticleModel], isPagination: Bool) {
        if isPagination {
            DispatchQueue.main.async { [weak self] in
                self?.newsArticles.append(contentsOf: newsArticles)
                self?.displayedNewsArticle.append(contentsOf: newsArticles)
                self?.tableView.reloadData()
                self?.tableView.finishInfiniteScroll()
            }
            
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.newsArticles = newsArticles
                self?.displayedNewsArticle = newsArticles
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
                self?.spinner.stopAnimating()
                
                self?.tableView.addInfiniteScroll(handler: { [weak self] table in
                    self?.presenter?.loadMoreData()
                })
            }
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.newsArticles = []
            self?.tableView.isHidden = true
            self?.label.text = error.localizedDescription
            self?.label.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    deinit {
        self.newsArticles = []
        self.displayedNewsArticle = []
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
        DispatchQueue.main.async { [weak self] in
            if let searchText = searchController.searchBar.text {
                if !searchText.isEmpty {
                    guard let displayedArticleFiltered = self?.displayedNewsArticle.filter({$0.title.localizedStandardContains(searchText)}) else { return }
                    self?.newsArticles = displayedArticleFiltered
                    self?.tableView.reloadData()
                } else {
                    guard let displayedArtcile = self?.displayedNewsArticle else { return }
                    self?.newsArticles = displayedArtcile
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    
}
