//
//  NewsSourceModel.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

struct NewsSourceResponse: Decodable {
    let status: String
    let sources: [NewsSourceModel]
}

struct NewsSourceModel: Decodable {
    let id, name, description: String
    let url: String
    let category: String
    let language, country: String
}
