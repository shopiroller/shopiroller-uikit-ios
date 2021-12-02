//
//  SearchViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.12.2021.
//

import UIKit

class SearchViewController: BaseViewController<SearchViewModel> {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    
    init(viewModel: SearchViewModel){
        super.init(viewModel: viewModel, nibName: SearchViewController.nibName, bundle: Bundle(for: SearchViewController.self))
    }
    
    override func setup() {
        super.setup()
        searchBar.placeholder = "search-bar-search-text".localized
        searchBar.keyboardType = .alphabet
        searchBar.delegate = self
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(cellClass: SearchTableViewCell.self)
        searchTableView.separatorStyle = .none
        searchTableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
}

extension SearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        let productListVC = ProductListViewController(viewModel: ProductListViewModel( title: viewModel.searchedKeyword, categoryTitle: viewModel.searchedKeyword))
        prompt(productListVC, animated: true, completion: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let keyword = searchBar.searchTextField.text , keyword != "" {
            viewModel.searchedKeyword = keyword
            if !SRAppContext.searchHistory.contains(keyword) {
                SRAppContext.searchHistory.append(keyword)
            }
            searchTableView.reloadData()
        }
    }
    
    @IBAction func backButtonTapped() {
        pop(animated: true, completion: nil)
    }
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SRAppContext.searchHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as! SearchTableViewCell
        cell.selectionStyle = .none
        cell.delegate = self
        cell.configureCell(title: SRAppContext.searchHistory[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let productListVC = ProductListViewController(viewModel: ProductListViewModel( title: SRAppContext.searchHistory[indexPath.row], categoryTitle: SRAppContext.searchHistory[indexPath.row]))
        prompt(productListVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
}

extension SearchViewController : SearchTableViewCellDelegate {
    func deleteButtonTapped(title: String?) {
        for keyword in SRAppContext.searchHistory {
            if keyword == title {
                let index = SRAppContext.searchHistory.firstIndex(of: keyword) ?? 0
                SRAppContext.searchHistory.remove(at: index)
            }
        }
        self.searchTableView.reloadData()
    }
}
