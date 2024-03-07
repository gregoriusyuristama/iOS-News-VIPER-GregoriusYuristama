//
//  NewsSourceInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

protocol NewsSourceInteractorInputProtocol {
    var presenter: NewsSourcesPresenterProtocol? { get set }
    var newsResponse: NewsSourceResponse? { get set }
    var category: String? { get set }
    
    func getNewsSources()
}

class NewsSourceInteractor: NewsSourceInteractorInputProtocol {
    
    var newsResponse: NewsSourceResponse?
    var category: String?
    
    var presenter: (any NewsSourcesPresenterProtocol)?
    
    var manager: NewsSourceManager
    
    init( manager: NewsSourceManager) {
        self.manager = manager
    }
    
    func getNewsSources() {
        guard let newsResponse else { return }
        self.presenter?.interactorDidFetchNewsSources(with: .success(newsResponse.sources.filter({$0.category == category})))
    }
    
    
}
