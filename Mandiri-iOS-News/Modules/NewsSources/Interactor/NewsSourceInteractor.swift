//
//  NewsSourceInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsSourceInteractor: NewsSourceInteractorProtocol {
    
    var newsResponse: NewsSourceResponse?
    var category: String?
    
    var presenter: (any NewsSourcesPresenterProtocol)?
    
    func getNewsSources() {
        guard let newsResponse else { return }
        self.presenter?.interactorDidFetchNewsSources(with: .success(newsResponse.sources.filter({$0.category == category})))
    }
    
    
}
