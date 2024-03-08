//
//  NewsCategoriesPresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/6/24.
//

import Foundation

class NewsCategoriesPresenter: NewsCategoriesPresenterProtocol {

    var router:  NewsCategoriesRouterProtocol?
    var interactor:  NewsCategoriesInteractorProtocol? {
        didSet {
            interactor?.getCategories()
        }
    }
    var view: NewsCategoriesViewProtocol?
    
    
    func interactorDidFetchCategories(with result: Result<NewsSourceResponse, any Error>) {
        switch result {
        case .success(let response):
            view?.update(with: response)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showNewsSource(_ newsResponse: NewsSourceResponse, category: String) {
        guard let view = view else { return }
        router?.presentNewsSource(from: view, for: newsResponse, category: category)
    }
    
    
}
