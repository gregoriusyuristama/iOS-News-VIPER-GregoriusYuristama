//
//  NewsWebviewPresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

protocol NewsWebviewPresenterProtocol {
    var router: NewsWebViewRouterProtocol? { get set }
    var interactor : NewsWebViewInteractorProtocol? { get set }
    var view: NewsWebViewContollerProtocol? { get set }
    
    func interactorDidGetNewsURL(with result: NewsArticleModel)
    
}

class NewsWebviewPresenter: NewsWebviewPresenterProtocol {
    var router:  NewsWebViewRouterProtocol?
    
    var interactor: NewsWebViewInteractorProtocol? {
        didSet {
            interactor?.getNewsArticle()
        }
    }
    
    var view:  NewsWebViewContollerProtocol?
    
    func interactorDidGetNewsURL(with result: NewsArticleModel) {
        if let newsUrl = URL(string: result.url) {
            view?.update(with: newsUrl)
        } else {
            view?.update(with: URLError(.cannotFindHost))
        }
    }
    
    
}
