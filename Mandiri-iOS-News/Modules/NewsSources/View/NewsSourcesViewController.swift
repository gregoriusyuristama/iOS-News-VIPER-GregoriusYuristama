//
//  NewsArticleSourcesViewController.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import UIKit

protocol NewsSourceViewProtocol {
    var presenter: NewsSourcesPresenterProtocol? { get set }
    
    func update(with newsSources: [NewsSourceModel])
    func update(with error: Error)
}


class NewsSourcesViewController: UIViewController, NewsSourceViewProtocol {
    
    var presenter: NewsSourcesPresenterProtocol?
    
    var spinner = UIActivityIndicatorView()
    var searchController = UISearchController(searchResultsController: nil)

    var newsSources: [NewsSourceModel] = []
    private var fetchedNewsSource: [NewsSourceModel] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "newsSourceCell")
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
    
    func update(with newsSources: [NewsSourceModel]) {
        DispatchQueue.main.async {
            self.newsSources = newsSources
            self.fetchedNewsSource = newsSources
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async {
            self.newsSources = []
            self.fetchedNewsSource = []
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = view.bounds
        label.center = view.center
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search News Sources"
    }

}



extension NewsSourcesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsSourceCell", for: indexPath)
        cell.textLabel?.text = newsSources[indexPath.row].name.capitalized
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showNewsArticle(newsSources[indexPath.row])
    }
    
    // TODO: Implement load more button when items < 25, infinite sscroll when items > 25
}

extension NewsSourcesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        DispatchQueue.main.async {
            if let searchText = searchController.searchBar.text {
                if !searchText.isEmpty {
                    self.newsSources = self.fetchedNewsSource.filter({$0.name.localizedStandardContains(searchText)})
                    self.tableView.reloadData()
                } else {
                    self.newsSources = self.fetchedNewsSource
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
