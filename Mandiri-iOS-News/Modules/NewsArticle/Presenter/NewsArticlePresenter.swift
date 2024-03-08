//
//  NewsArticlePresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsArticlePresenter: NewsArticlePresenterProtocol {
    var fetchedNewsArticle: [NewsArticleModel]?
    
    var isPaginationAvailable: Bool?

    var router: NewsArticleRouterProtocol?
    
    var interactor: NewsArticleInteractorProtocol? {
        didSet {
            interactor?.getNewsArticles()
        }
    }
    
    var view: NewsArticleViewProtocol?
    
    func interactorDidFetchNewsArticles(with result: Result<[NewsArticleModel], any Error>, isPagination: Bool, isPaginationAvailable: Bool) {
        switch result {
        case .success(let success):
            if isPagination {
                self.fetchedNewsArticle?.append(contentsOf: success)
            } else {
                self.fetchedNewsArticle = success
            }
            view?.update(with: success, isPagination: isPagination)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showNewsWebView(news: NewsArticleModel) {
        guard let view = view else { return }
        router?.presentNewsArticleWebView(from: view, for: news)
    }
    
    func loadMoreData() {
        interactor?.loadMoreNewsArticles()
    }
    
    func searchNewsArticle(_ searchText: String) {
        if !searchText.isEmpty {
            guard let searchedNews = fetchedNewsArticle?.filter( {$0.title.localizedCaseInsensitiveContains(searchText)}) else { return }
            view?.update(with: searchedNews, isPagination: false)
        } else {
            guard let fetchedNewsSource = fetchedNewsArticle else { return }
            view?.update(with: fetchedNewsSource, isPagination: false)
        }
    }
    
}
