//
//  NewsWebViewProtocol.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

protocol NewsWebViewRouterProtocol {
    static func createModule(with newsArticle: NewsArticleModel) -> UIViewController
}

protocol NewsWebViewContollerProtocol {
    var presenter: NewsWebviewPresenterProtocol? { get set }
    func update(with newsUrl: URL)
    func update(with error: Error)
}

protocol NewsWebviewPresenterProtocol {
    var router: NewsWebViewRouterProtocol? { get set }
    var interactor : NewsWebViewInteractorProtocol? { get set }
    var view: NewsWebViewContollerProtocol? { get set }
    
    func interactorDidGetNewsURL(with result: NewsArticleModel)
    
}

protocol NewsWebViewInteractorProtocol {
    var presenter: NewsWebviewPresenterProtocol? { get set }
    var newsArticle: NewsArticleModel? { get set }
    
    func getNewsArticle()
}
