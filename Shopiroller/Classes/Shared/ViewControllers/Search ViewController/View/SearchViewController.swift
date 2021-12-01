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
        
        if viewModel.searchedKeyword != nil , viewModel.searchedKeyword != "" {
            let productListVC = ProductListViewController(viewModel: ProductListViewModel( title: viewModel.searchedKeyword, categoryTitle: viewModel.searchedKeyword))
            prompt(productListVC, animated: true, completion: nil)
        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.searchedKeyword = searchBar.searchTextField.text
    }
}

extension SearchViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //TODO Search History Array Count
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reuseIdentifier) as! SearchTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
}
