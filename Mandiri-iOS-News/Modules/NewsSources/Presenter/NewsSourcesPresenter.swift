//
//  NewsSourcesPresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

protocol NewsSourcesPresenterProtocol {
    var router: NewsSourceRouterProtocol? { get set }
    var interactor: NewsSourceInteractorInputProtocol? { get set }
    var view: NewsSourceViewProtocol? { get set }
    
    func interactorDidFetchNewsSources(with result: Result<[NewsSourceModel], Error>)
    func showNewsArticle(_ source: NewsSourceModel)
}

class NewsSourcesPresenter: NewsSourcesPresenterProtocol {
    
    var router: NewsSourceRouterProtocol?
    var interactor: NewsSourceInteractorInputProtocol? {
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
