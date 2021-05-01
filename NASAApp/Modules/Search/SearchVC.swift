//
//  SearchVC.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.05.2021.
//

import UIKit

class SearchVC: UIViewController {
    let service = SearchService()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        search(isInitial: true)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
    }
    

    func search(isInitial: Bool) {
        if isInitial {
            service.reset()
        }
        
        service.search(keywords: "sun star") { (isPaging) in
            
        }
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if service.isNeedLoading(indexPaths: indexPaths) {
            search(isInitial: false)
        }
    }
}



