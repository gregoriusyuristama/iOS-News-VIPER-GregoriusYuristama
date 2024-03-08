//
//  ViewController.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/6/24.
//

import UIKit

class NewsCategoriesViewController: UIViewController, NewsCategoriesViewProtocol  {
    
    var spinner = UIActivityIndicatorView()
    var presenter: NewsCategoriesPresenterProtocol?
    var categories: [NewsSourceModel] = []
    var newsResponse: NewsSourceResponse?
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        view.addSubview(label)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = view.bounds
        label.center = view.center
    }
    
    

    func update(with newsResponse: NewsSourceResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.newsResponse = newsResponse
            let uniqueCategoryId = Set(newsResponse.sources.compactMap({$0.category}))
            let uniqueCategories = uniqueCategoryId.compactMap { category in
                newsResponse.sources.first(where: {$0.category == category})
            }.sorted(by: {$0.category < $1.category})
            self?.categories = uniqueCategories
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.categories = []
            self?.tableView.isHidden = true
            self?.label.text = error.localizedDescription
            self?.label.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
}

extension NewsCategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].category.capitalized
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let newsResponse else { return }
        presenter?.showNewsSource(newsResponse, category: categories[indexPath.row].category)
    }
}

