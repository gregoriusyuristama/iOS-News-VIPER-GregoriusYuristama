//
//  NewsSourceManager.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsSourceManager: NewsSourceManagerInputProtocol {
    
    func getNewsSources(completion: @escaping (NewsSourceResponse? , Error?) -> ()) {
        NewsAPI.shared.getNewsSources { result in
            switch result {
            case .success(let success):
                completion(success, nil)
            case .failure(let failure):
                completion(nil, failure)
            }
        }
    }
}
