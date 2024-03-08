//
//  NewsCategoriesProtocol.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation
import UIKit

typealias EntryPoint = UINavigationController

protocol NewsCategoriesInteractorProtocol {
    var presenter: NewsCategoriesPresenterProtocol? { get set }
    
    
    func getCategories()
}

protocol NewsCategoriesPresenterProtocol {
    
    var router: NewsCategoriesRouterProtocol? { get set }
    var interactor: NewsCategoriesInteractorProtocol? { get set }
    var view: NewsCategoriesViewProtocol? { get set }
    
    func interactorDidFetchCategories(with result: Result<NewsSourceResponse, Error>)
    func showNewsSource(_ newsResponse: NewsSourceResponse, category: String)
}


protocol NewsCategoriesViewProtocol {
    var presenter: NewsCategoriesPresenterProtocol? { get set }
    
    func update(with newsResponse: NewsSourceResponse)
    func update(with error: Error)
}


protocol NewsCategoriesRouterProtocol {
    var entry: EntryPoint? { get }
    
    static func createModule(usingNavigationFactory factory: NavigationFactory) -> NewsCategoriesRouterProtocol
    
    func presentNewsSource(from view: NewsCategoriesViewProtocol, for newsResponse: NewsSourceResponse, category: String)
}

protocol NewsSourceManagerInputProtocol {
    func getNewsSources(completion: @escaping (NewsSourceResponse? , Error?) -> ())
}
