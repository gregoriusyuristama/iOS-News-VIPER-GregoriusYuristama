//
//  NewsArticleManager.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

protocol NewsArticleManagerProtocol {
    func getNewsArticles(category: String, sourceId: String, completion: @escaping (NewsArticleResponse?, Error?) -> ())
}

class NewsArticleManager: NewsArticleManagerProtocol {
    
    static var shared = NewsArticleManager()
    
    func getNewsArticles(category: String, sourceId: String, completion: @escaping (NewsArticleResponse?, (any Error)?) -> ()) {
        NewsAPI.shared.getNewsArticleWithCategoryAndSource(with: category, and: sourceId) { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
    
    
}
