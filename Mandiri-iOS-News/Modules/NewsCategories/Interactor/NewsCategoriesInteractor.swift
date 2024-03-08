//
//  NewsCategoriesInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/6/24.
//

import Foundation

class NewsCategoriesInteractor: NewsCategoriesInteractorProtocol {
    var presenter: NewsCategoriesPresenterProtocol?
    
    var manager: NewsSourceManager
    
    init(manager: NewsSourceManager) {
        self.manager = manager
    }
    
    func getCategories() {
        manager.getNewsSources { newsSourceResponse, error in
            if let newsSourceResponse = newsSourceResponse {
                self.presenter?.interactorDidFetchCategories(with: .success(newsSourceResponse))
            } else {
                self.presenter?.interactorDidFetchCategories(with: .failure(error!))
            }
        }
    }
}
