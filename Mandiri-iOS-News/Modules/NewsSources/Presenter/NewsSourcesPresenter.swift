//
//  NewsSourcesPresenter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsSourcesPresenter: NewsSourcesPresenterProtocol {
    var isPaginationAvailable: Bool?
    var fetchedNewsSource: [NewsSourceModel]?
    var router: NewsSourceRouterProtocol?
    var interactor: NewsSourceInteractorProtocol? {
        didSet {
            interactor?.getNewsSources()
        }
    }
    var view: NewsSourceViewProtocol?
    
    func interactorDidFetchNewsSources(with result: Result<[NewsSourceModel], any Error>, isPagination: Bool, isPaginationAvailable: Bool) {
        self.isPaginationAvailable = isPaginationAvailable
        switch result {
        case .success(let articles):
            if !isPagination {
                self.fetchedNewsSource = articles
            } else {
                self.fetchedNewsSource?.append(contentsOf: articles)
            }
            view?.update(with: articles, isPagination: isPagination)
        case .failure(let failure):
            view?.update(with: failure)
        }
    }
    
    func showNewsArticle(_ source: NewsSourceModel) {
        guard let view = view, let category = interactor?.category else { return }
        router?.presentNewsArticles(from: view, for: source, and: category)
    }
    
    func searchNews(_ searchText: String) {
        if !searchText.isEmpty {
            guard let searchedNews = fetchedNewsSource?.filter( { news in
                guard let name = news.name else { return false }
                return name.localizedCaseInsensitiveContains(searchText)
            }) else { return }
            view?.update(with: searchedNews, isPagination: false)
        } else {
            guard let fetchedNewsSource = fetchedNewsSource else { return }
            view?.update(with: fetchedNewsSource, isPagination: false)
        }
    }
    
    func loadMoreNewsSource() {
        interactor?.getMoreNewsSource()
    }
    
}
