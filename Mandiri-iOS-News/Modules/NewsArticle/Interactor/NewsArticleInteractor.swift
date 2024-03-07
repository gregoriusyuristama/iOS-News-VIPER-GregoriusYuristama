//
//  NewsArticleInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

protocol NewsArticleInteractorProtocol {
    var presenter: NewsArticlePresenterProtocol? { get set }
    var newsSource: NewsSourceModel? { get set }
    var newsCategory: String? { get set }
    var manager: NewsArticleManager { get }
    
    func getNewsArticles()
    
}

class NewsArticleInteractor: NewsArticleInteractorProtocol {
    var presenter: NewsArticlePresenterProtocol?
    
    var newsSource: NewsSourceModel?
    var newsCategory: String?
    
    var manager: NewsArticleManager
    
    init(manager: NewsArticleManager) {
        self.manager = manager
    }
    
    func getNewsArticles() {
        guard let newsSource = newsSource, let newsCategory = newsCategory else { return }
        
        manager.getNewsArticles(category: newsCategory, sourceId: newsSource.id) { newsArticleResponse, error in
            if let newsArticleResponse = newsArticleResponse {
                self.presenter?.interactorDidFetchNewsArticles(with: .success(newsArticleResponse.articles))
            } else {
                self.presenter?.interactorDidFetchNewsArticles(with: .failure(error!))
            }
        }
    }
    
    
}
