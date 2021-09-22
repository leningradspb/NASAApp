//
//  SearchVC.swift
//  NASAApp
//
//  Created by Eduard Sinyakov on 01.05.2021.
//

import UIKit
import SnapKit

class SearchVC: UIViewController {
    let service = SearchService()
    let tableView = UITableView()
    private let searchBar = UISearchBar()
    private var pendingRequestWorkItem: DispatchWorkItem?
    
    
    private var keywords: String {
        searchBar.text ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

//        search(isInitial: true)
        setupSearchBar()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    

    func search(isInitial: Bool) {
        if isInitial {
            service.reset()
        }
        
        service.search(keywords: keywords) { (isPaging) in
            
        }
    }
    
    private func setupSearchBar() {
        
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.barTintColor = ThemeService.shared.viewColor
        searchBar.delegate = self
        searchBar.placeholder = "Найти"
//        searchBar.showsCancelButton = true
        searchBar.keyboardType = .asciiCapable
    }
    
    @objc private func showSearchBar() {
        
    }
    
    @objc private func cancelSearch() {
        searchBar.text = nil
        hideKeyboard()
        search(isInitial: true)
    }
    
    @objc private func hideKeyboard() {
        searchBar.endEditing(true)
    }

}

extension SearchVC: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        service.total
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

extension SearchVC: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
//        searchCancelButton.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
//        self.search(isInitial: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        hideKeyboard()
        self.search(isInitial: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        pendingRequestWorkItem?.cancel()
        
        let requestWorkItem = DispatchWorkItem { [weak self] in
            guard let self = self else { return }
            
//            self.requestWithoutElement(searchText)
            self.search(isInitial: true)
        }

        pendingRequestWorkItem = requestWorkItem
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(350),
                                      execute: requestWorkItem)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
}





final class HorizontalStackView: UIStackView {
    init(distribution: UIStackView.Distribution = .fill, spacing: CGFloat, alignment: UIStackView.Alignment = .fill) {
        super.init(frame: .zero)
        axis = .horizontal
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

