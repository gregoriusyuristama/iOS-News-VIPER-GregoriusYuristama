//
//  NewsWebViewInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsWebViewInteractor: NewsWebViewInteractorProtocol {
    var presenter: NewsWebviewPresenterProtocol?
    
    var newsArticle: NewsArticleModel?
    
    func getNewsArticle() {
        guard let newsArticle else { return }
        
        presenter?.interactorDidGetNewsURL(with: newsArticle)
    }
    
    
}
