//
//  NewsWebViewRouter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation
import UIKit

protocol NewsWebViewRouterProtocol {
    static func createModule(with newsArticle: NewsArticleModel) -> UIViewController
}

class NewsWebViewRouter: NewsWebViewRouterProtocol {
    static func createModule(with newsArticle: NewsArticleModel) -> UIViewController {
        let router = NewsWebViewRouter()
        
        var view: NewsWebViewContollerProtocol = NewsWebViewContoller()
        var presenter: NewsWebviewPresenterProtocol = NewsWebviewPresenter()
        var interactor: NewsWebViewInteractorProtocol = NewsWebViewInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        interactor.newsArticle = newsArticle
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Protocol Type") }
        viewController.navigationItem.title = newsArticle.title
        
        return viewController
    }
    
    
}
