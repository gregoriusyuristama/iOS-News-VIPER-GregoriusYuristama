//
//  NewsAPI.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/6/24.
//

import Foundation
import Alamofire


class NewsAPI {
    
    static var shared = NewsAPI()
    
    private var newsAPIHeaders = HTTPHeaders([
        HTTPHeader(name: "x-api-key", value: APIConstant.apiKey)
    ])
    
    func getNewsSources(completion: @escaping (Result<NewsSourceResponse, Error>) -> Void) {
        let newsSourceURL = APIConstant.baseApiURL+APIConstant.getNewsCategoriesURL
        
        AF.request(newsSourceURL, method: .get, headers: self.newsAPIHeaders).responseDecodable(of: NewsSourceResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func getMoreNewsArticleWithCategoryAndSource(with category: String, and sourceId: String, pages: Int? = nil, completion: @escaping (Result<NewsArticleResponse, Error>) -> Void) {
        
        var newsSourceURL = "\(APIConstant.baseApiURL)\(APIConstant.getNewsSourceWithCategory)\(category)&sources.id=\(sourceId)"
        
        if let pages {
            newsSourceURL += "&page=\(pages)"
        }
            
        AF.request(newsSourceURL, method: .get, headers: self.newsAPIHeaders).responseDecodable(of: NewsArticleResponse.self) { response in
            switch response.result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
