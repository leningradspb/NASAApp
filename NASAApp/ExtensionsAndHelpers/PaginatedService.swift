//
//  PaginatedService.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.05.2021.
//

import Foundation

class PaginatedService<TCollection> {

    // MARK: - page
    private var page = 1
    // MARK: - elements per page
    let limit = 25

    var collection: [TCollection] = []

    var isLoading = false

    var currentPage: Int {
        page
    }

    func isNeedLoading(indexPaths: [IndexPath]) -> Bool {
        indexPaths.contains { $0.row >= collection.count }
    }

    subscript(index: Int) -> TCollection? {
        if index < collection.count {
            return collection[index]
        }

        return nil
    }

    func reset() {
        collection.removeAll()
        page = 1
    }

    func load(items: [TCollection]?, completion: @escaping (Bool) -> Void) {
        let isPaging = page > 1

        if let items = items {
            appendCollection(items: items)
        }

        isLoading = false

        completion(isPaging)
    }

    func calculateVisibleIndexPathsToReload(visible: [IndexPath]?, loading: [IndexPath]) -> [IndexPath] {
        let indexPathsIntersection = Set(visible ?? []).intersection(loading)

        return Array(indexPathsIntersection)
    }

    private func calculateIndexPathsToReload(from items: [TCollection]) -> [IndexPath] {
        let startIndex = collection.count - items.count
        let endIndex = startIndex + items.count

        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }

    private func appendCollection(items: [TCollection]) {
        collection.append(contentsOf: items)
        page += 1
    }
}
