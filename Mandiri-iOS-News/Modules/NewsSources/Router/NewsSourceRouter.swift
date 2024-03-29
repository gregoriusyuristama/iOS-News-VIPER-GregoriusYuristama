//
//  NewsSourceRouter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation
import UIKit

class NewsSourceRouter: NewsSourceRouterProtocol {

    static func createModule(with newsResponse: NewsSourceResponse, and category: String) -> UIViewController {
        let router = NewsSourceRouter()
        
        var view: NewsSourceViewProtocol = NewsSourcesViewController()
        var presenter: NewsSourcesPresenterProtocol = NewsSourcesPresenter()
        var interactor: NewsSourceInteractorProtocol = NewsSourceInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.newsResponse = newsResponse
        interactor.category = category
        interactor.fetchedNewsCount = 0
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid view protocol Type") }
        
       viewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        return viewController
    }
    
    func presentNewsArticles(from view: any NewsSourceViewProtocol, for source: NewsSourceModel, and category: String) {
        let newsArticlesViewController = NewsArticleRouter.createModule(with: source, and: category)
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller ") }
        
        viewController.navigationController?.pushViewController(newsArticlesViewController, animated: true)
    }
    
    
}
