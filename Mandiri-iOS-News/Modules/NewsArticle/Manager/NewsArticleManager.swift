//
//  NewsArticleManager.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

class NewsArticleManager: NewsArticleManagerProtocol {

    func getNewsArticles(category: String, sourceId: String, completion: @escaping (NewsArticleResponse?, (any Error)?) -> ()) {
        NewsAPI.shared.getMoreNewsArticleWithCategoryAndSource(with: category, and: sourceId, pages: nil) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
    
    func getNewsArticles(category: String, sourceId: String, pages: Int?, completion: @escaping (NewsArticleResponse?, (any Error)?) -> ()) {
        NewsAPI.shared.getMoreNewsArticleWithCategoryAndSource(with: category, and: sourceId, pages: pages) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
    
}
