//
//  NewsSourceInteractor.swift
//  Mandiri-iOS-News
//
//  Created by Gregorius Yuristama Nugraha on 3/7/24.
//

import Foundation

class NewsSourceInteractor: NewsSourceInteractorProtocol {
    var fetchedNewsCount: Int?
    var newsResponse: NewsSourceResponse?
    var category: String?
    
    var presenter: (any NewsSourcesPresenterProtocol)?
    
    func getNewsSources() {
        guard let newsResponse else { return }
        let newsSourceFromCategory = newsResponse.sources.filter({$0.category == category})
        let slicedNewsSource = sliceNewsSource(newsSourceFromCategory)
        self.presenter?.interactorDidFetchNewsSources(with: .success(slicedNewsSource), isPagination: false, isPaginationAvailable: ( slicedNewsSource.count >= 20))
    }
    
    func getMoreNewsSource() {
        guard let newsResponse, var fetchedNewsCount else { return }
        let newsSourceFromCategory = newsResponse.sources.filter({$0.category == category})
        let fetch = fetchMoreSlicedNewsSource(currentCount: fetchedNewsCount, newsSourceFromCategory)
        
        self.fetchedNewsCount = fetchedNewsCount + fetch.count
        self.presenter?.interactorDidFetchNewsSources(with: .success(fetch), isPagination: true, isPaginationAvailable: ( self.fetchedNewsCount! < newsSourceFromCategory.count ))
    }
    
    private func sliceNewsSource(_ fetchedNewsSource: [NewsSourceModel]) -> [NewsSourceModel]{
        if fetchedNewsSource.count > 20 {
            let slicedNewsSource = Array(fetchedNewsSource[..<20])
            self.fetchedNewsCount = slicedNewsSource.count
            return slicedNewsSource
        } else {
            return fetchedNewsSource
        }
    }
    
    private func fetchMoreSlicedNewsSource(currentCount: Int,  _ fetchedNewsSource: [NewsSourceModel]) -> [NewsSourceModel] {
        var lastIndex = 0
        if currentCount + 20 > fetchedNewsSource.count - 1 {
            lastIndex = fetchedNewsSource.count - 1
        } else {
            lastIndex = currentCount + 19
        }
        let slicedFetchedNewsSource = Array(fetchedNewsSource[currentCount...lastIndex])
        
        return slicedFetchedNewsSource
    }
    
    
}
