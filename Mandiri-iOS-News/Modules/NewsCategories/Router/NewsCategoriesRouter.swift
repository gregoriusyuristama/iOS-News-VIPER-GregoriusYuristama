//
//  NewsCategoriesRouter.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/6/24.
//

import Foundation
import UIKit

typealias EntryPoint = UINavigationController

protocol NewsCategoriesRouterProtocol {
    var entry: EntryPoint? { get }
    
    static func createModule(usingNavigationFactory factory: NavigationFactory) -> NewsCategoriesRouterProtocol
    
    func presentNewsSource(from view: NewsCategoriesViewProtocol, for newsResponse: NewsSourceResponse, category: String)
}

class NewsCategoriesRouter: NewsCategoriesRouterProtocol {
    var entry: EntryPoint?
    
    static func createModule(usingNavigationFactory factory: NavigationFactory) -> NewsCategoriesRouterProtocol {
        let router = NewsCategoriesRouter()
        
        var view: NewsCategoriesViewProtocol = NewsCategoriesViewController()
        var presenter: NewsCategoriesPresenterProtocol = NewsCategoriesPresenter()
        let newsSourceManager = NewsSourceManager()
        var interactor: NewsCategoriesInteractorProtocol = NewsCategoriesInteractor(manager: newsSourceManager)
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        guard let viewEntry = view as? UIViewController else { fatalError("Invalid UI Type")}
        
        router.entry = factory(viewEntry)
        
        return router
    }
    
    func presentNewsSource(from view: any NewsCategoriesViewProtocol, for newsResponse: NewsSourceResponse, category: String) {
        let newsSourcesViewController = NewsSourceRouter.createModule(with: newsResponse, and: category)
        guard let viewController = view as? UIViewController else { fatalError("Invalid View Controller" ) }
        
        newsSourcesViewController.navigationItem.title = category.capitalized
        
        viewController.navigationController?.pushViewController(newsSourcesViewController, animated: true)
    }
}
