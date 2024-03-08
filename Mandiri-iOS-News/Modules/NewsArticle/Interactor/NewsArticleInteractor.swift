//
//  NewsArticleInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsArticleInteractor: NewsArticleInteractorProtocol {
    
    var presenter: NewsArticlePresenterProtocol?
    
    var newsSource: NewsSourceModel?
    var newsCategory: String?
    
    var manager: NewsArticleManager
    var pages = 1
    
    init(manager: NewsArticleManager) {
        self.manager = manager
    }
    
    func getNewsArticles() {
        guard let newsSource = newsSource, let newsCategory = newsCategory else { return }
        
        manager.getNewsArticles(category: newsCategory, sourceId: newsSource.id) { newsArticleResponse, error in
            if let newsArticleResponse = newsArticleResponse{
                self.presenter?.interactorDidFetchNewsArticles(with: .success(newsArticleResponse.articles), isPagination: false, isPaginationAvailable: ( newsArticleResponse.articles.count < newsArticleResponse.totalResults ))
            } else {
                self.presenter?.interactorDidFetchNewsArticles(with: .failure(error!), isPagination: false, isPaginationAvailable: false)
            }
        }
    }
    
    func loadMoreNewsArticles() {
        guard let newsSource = newsSource, let newsCategory = newsCategory, let fetchedNewsArticle = presenter?.fetchedNewsArticle else { return }
        
        pages += 1
        
        manager.getNewsArticles(category: newsCategory, sourceId: newsSource.id, pages: self.pages) { newsArticleResponse, error in
            if let newsArticleResponse = newsArticleResponse {
                self.presenter?.interactorDidFetchNewsArticles(with: .success(newsArticleResponse.articles), isPagination: true, isPaginationAvailable: ( fetchedNewsArticle.count < newsArticleResponse.totalResults ))
            } else {
                self.presenter?.interactorDidFetchNewsArticles(with: .failure(error!), isPagination: false, isPaginationAvailable: false)
            }
        }
    }
    
    
}
