//
//  NewsSourceProtocol.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

protocol NewsSourceRouterProtocol {
    
    static func createModule(with newsResponse: NewsSourceResponse, and category: String) -> UIViewController
    
    func presentNewsArticles(from view: NewsSourceViewProtocol, for source: NewsSourceModel, and category: String)
}

protocol NewsSourceViewProtocol {
    var presenter: NewsSourcesPresenterProtocol? { get set }
    
    func update(with newsSources: [NewsSourceModel])
    func update(with error: Error)
}

protocol NewsSourcesPresenterProtocol {
    var router: NewsSourceRouterProtocol? { get set }
    var interactor: NewsSourceInteractorProtocol? { get set }
    var view: NewsSourceViewProtocol? { get set }
    
    func interactorDidFetchNewsSources(with result: Result<[NewsSourceModel], Error>)
    func showNewsArticle(_ source: NewsSourceModel)
}

protocol NewsSourceInteractorProtocol {
    var presenter: NewsSourcesPresenterProtocol? { get set }
    var newsResponse: NewsSourceResponse? { get set }
    var category: String? { get set }
    
    func getNewsSources()
}

