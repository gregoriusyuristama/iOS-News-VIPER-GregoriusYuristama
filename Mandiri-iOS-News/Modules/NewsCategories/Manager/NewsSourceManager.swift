//
//  NewsSourceManager.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

protocol NewsSourceManagerInputProtocol {
    func getNewsSources(completion: @escaping (NewsSourceResponse? , Error?) -> ())
    
}

class NewsSourceManager: NewsSourceManagerInputProtocol {
    
    static var shared = NewsSourceManager()
    
    var newsSourceResponse: NewsSourceResponse?
    
    func getNewsSources(completion: @escaping (NewsSourceResponse? , Error?) -> ()) {
        NewsAPI.shared.getNewsSources { [weak self] result in
            switch result {
            case .success(let success):
                self?.newsSourceResponse = success
                completion(self?.newsSourceResponse, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
