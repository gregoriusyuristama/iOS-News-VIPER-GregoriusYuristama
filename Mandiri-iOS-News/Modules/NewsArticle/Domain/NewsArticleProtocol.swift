//
//  NewsArticleProtocol.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

protocol NewsArticleInteractorProtocol {
    var presenter: NewsArticlePresenterProtocol? { get set }
    var newsSource: NewsSourceModel? { get set }
    var newsCategory: String? { get set }
    var manager: NewsArticleManager { get }
    
    func getNewsArticles()
    func loadMoreNewsArticles()
}

protocol NewsArticleManagerProtocol {
    func getNewsArticles(category: String, sourceId: String, completion: @escaping (NewsArticleResponse?, Error?) -> ())
    
    func getMoreNewsArticle(category: String, sourceId: String, pages: Int, completion: @escaping (NewsArticleResponse?, Error?) -> ())
}

protocol NewsArticlePresenterProtocol {
    var router: NewsArticleRouterProtocol? { get set }
    var interactor: NewsArticleInteractorProtocol? { get set }
    var view: NewsArticleViewProtocol? { get set }
    
    func interactorDidFetchNewsArticles(with result: Result<[NewsArticleModel], Error>)
    func interactorDidFetchMoreNewsArticle(with result: Result<[NewsArticleModel], Error>)
    func showNewsWebView(news: NewsArticleModel)
    
    func loadMoreData()
}

protocol NewsArticleViewProtocol {
    var presenter: NewsArticlePresenterProtocol? { get set }
    
    func update(with newsArticles: [NewsArticleModel], isPagination: Bool)
    func update(with newsArticles: Error)
}


protocol NewsArticleRouterProtocol {
    static func createModule(with source: NewsSourceModel, and category: String) -> UIViewController
    func presentNewsArticleWebView(from view: NewsArticleViewProtocol, for news: NewsArticleModel)
}
