//
//  NewsArticleModel.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation


struct NewsArticleResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [NewsArticleModel]
}

// MARK: - Article
struct NewsArticleModel: Codable {
    let source: NewsArticleSource
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
//    let publishedAt: Date
    let content: String?
}

// MARK: - Source
struct NewsArticleSource: Codable {
    let id: String?
    let name: String?
}
