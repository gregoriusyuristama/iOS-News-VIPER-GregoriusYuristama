//
//  NewsSourcesPresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsSourcesPresenter: NewsSourcesPresenterProtocol {
    
    var router: NewsSourceRouterProtocol?
    var interactor: NewsSourceInteractorProtocol? {
        didSet {
            interactor?.getNewsSources()
        }
    }
    var view: NewsSourceViewProtocol?
    
    func interactorDidFetchNewsSources(with result: Result<[NewsSourceModel], any Error>) {
        switch result {
        case .success(let articles):
            view?.update(with: articles)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showNewsArticle(_ source: NewsSourceModel) {
        guard let view = view, let category = interactor?.category else { return }
        router?.presentNewsArticles(from: view, for: source, and: category)
    }
    
    
    
}
