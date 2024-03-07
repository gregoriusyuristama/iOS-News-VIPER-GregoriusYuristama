//
//  NewsArticlePresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

protocol NewsArticlePresenterProtocol {
    var router: NewsArticleRouterProtocol? { get set }
    var interactor: NewsArticleInteractorProtocol? { get set }
    var view: NewsArticleViewProtocol? { get set }
    
    func interactorDidFetchNewsArticles(with result: Result<[NewsArticleModel], Error>)
    func showNewsWebView(news: NewsArticleModel)
    
}

class NewsArticlePresenter: NewsArticlePresenterProtocol {

    var router: NewsArticleRouterProtocol?
    
    var interactor: NewsArticleInteractorProtocol? {
        didSet {
            interactor?.getNewsArticles()
        }
    }
    
    var view: NewsArticleViewProtocol?
    
    func interactorDidFetchNewsArticles(with result: Result<[NewsArticleModel], any Error>) {
        switch result {
        case .success(let response):
            view?.update(with: response)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showNewsWebView(news: NewsArticleModel) {
        guard let view = view else { return }
        
        router?.presentNewsArticleWebView(from: view, for: news)
    }
    
    
}
