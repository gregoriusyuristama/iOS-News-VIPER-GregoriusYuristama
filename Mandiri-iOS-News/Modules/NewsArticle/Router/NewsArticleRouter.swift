//
//  NewsArticleRouter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation
import UIKit

protocol NewsArticleRouterProtocol {
    static func createModule(with source: NewsSourceModel, and category: String) -> UIViewController
    func presentNewsArticleWebView(from view: NewsArticleViewProtocol, for news: NewsArticleModel)
}

class NewsArticleRouter: NewsArticleRouterProtocol {
    static func createModule(with source: NewsSourceModel, and category: String) -> UIViewController {
        let router = NewsArticleRouter()
        
        var view: NewsArticleViewProtocol = NewsArticleViewController()
        var presenter: NewsArticlePresenterProtocol = NewsArticlePresenter()
        let newsArticleManager = NewsArticleManager()
        var interactor: NewsArticleInteractorProtocol = NewsArticleInteractor(manager: newsArticleManager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.newsSource = source
        interactor.newsCategory = category
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Protocol Type") }
        
        viewController.navigationItem.title = source.name.capitalized
        
        return viewController
    }
    
    func presentNewsArticleWebView(from view: NewsArticleViewProtocol, for news: NewsArticleModel) {
        let newsWebViewController = NewsWebViewRouter.createModule(with: news)
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller ") }
        
        viewController.navigationController?.pushViewController(newsWebViewController, animated: true)
    }
    
    
}
