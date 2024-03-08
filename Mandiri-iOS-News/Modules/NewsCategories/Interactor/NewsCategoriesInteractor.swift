//
//  NewsCategoriesInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/6/24.
//

import Foundation

class NewsCategoriesInteractor: NewsCategoriesInteractorProtocol {
    var newsResponse: NewsSourceResponse?
    
    var presenter: NewsCategoriesPresenterProtocol?
    
    var manager: NewsSourceManager
    
    init(manager: NewsSourceManager) {
        self.manager = manager
    }
    
    func getCategories() {
        manager.getNewsSources { newsSourceResponse, error in
            if let newsSourceResponse = newsSourceResponse {
                self.newsResponse = newsSourceResponse
                self.presenter?.interactorDidFetchCategories(with: .success(self.mapCategoryFromResponse(newsSourceResponse)))
            } else {
                self.presenter?.interactorDidFetchCategories(with: .failure(error!))
            }
        }
    }
    
    private func mapCategoryFromResponse(_ newsResponse: NewsSourceResponse) -> [NewsSourceModel] {
        let uniqueCategoryId = Set(newsResponse.sources.compactMap({$0.category}))
        return uniqueCategoryId.compactMap { category in
            newsResponse.sources.first(where: {$0.category == category})
        }.sorted(by: {$0.category < $1.category})
    }
}
