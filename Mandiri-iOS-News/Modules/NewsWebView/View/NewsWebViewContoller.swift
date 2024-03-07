//
//  NewsArticleWebView.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import UIKit
import WebKit

protocol NewsWebViewContollerProtocol {
    var presenter: NewsWebviewPresenterProtocol? { get set }
    func update(with newsUrl: URL)
    func update(with error: Error)
}

class NewsWebViewContoller: UIViewController, NewsWebViewContollerProtocol, WKUIDelegate, WKNavigationDelegate {
    
    var presenter: NewsWebviewPresenterProtocol?
    var spinner = UIActivityIndicatorView()
    
    private var webView: WKWebView = {
        let webView = WKWebView()
        webView.isHidden = true
        return webView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    
    func update(with newsUrl: URL) {
        self.webView.load(URLRequest(url: newsUrl))
        self.webView.isHidden = false
        self.label.isHidden = true
    }
    
    func update(with error: any Error) {
        self.label.text = error.localizedDescription
        self.label.isHidden = false
        self.webView.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(label)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        label.frame = view.bounds
        label.center = view.center
    }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: any Error) {
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        spinner.startAnimating()
    }
}
