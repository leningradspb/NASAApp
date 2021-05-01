//
//  SearchService.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.05.2021.
//

import UIKit

class SearchService : PaginatedService<Item> {
    
    private let apiService = ApiService()
    var model: SearchModel?
    
    var total: Int {
        return model?.collection?.metadata?.total_hits ?? 0
    }
    
    func search(keywords: String?, completion: @escaping (Bool) -> ()) {
        if isLoading {
            return
        }
        
        isLoading = true
        apiService.search(keywords: keywords, page: currentPage) { [weak self] result, error in
            guard let self = self else { return }
            print(result?.collection?.items?.count, result?.collection?.metadata?.total_hits)
            self.model = result
            self.load(items: result?.collection?.items, completion: completion)
        }
        
    }
}
