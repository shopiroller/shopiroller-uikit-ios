//
//  SearchViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 1.12.2021.
//

import UIKit

private struct Constants {
    
    static var searchText : String { return "search_bar_search_text".localized }
    
}

class SRSearchViewController: BaseViewController<SRSearchViewModel> {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var searchTableView: UITableView!
    @IBOutlet private weak var backButton: UIButton!
    
    init(viewModel: SRSearchViewModel){
        super.init(viewModel: viewModel, nibName: SRSearchViewController.nibName, bundle: Bundle(for: SRSearchViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        searchBar.delegate = self
        searchBar.setSearchBar(placeholder: Constants.searchText)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(cellClass: SearchTableViewCell.self)
        searchTableView.separatorStyle = .none
        searchTableView.tableFooterView = UIView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension SRSearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if viewModel.searchedKeyword != nil , viewModel.searchedKeyword != "" {
            let productListVC = SRProductListViewController(viewModel: SRProductListViewModel( title: viewModel.searchedKeyword, pageTitle: viewModel.searchedKeyword))
            prompt(productListVC, animated: true, completion: nil)
        }
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let keyword = searchBar.searchTextField.text , !keyword.isEmpty {
            viewModel.searchedKeyword = keyword
            if !SRAppContext.searchHistory.contains(keyword) {
                SRAppContext.searchHistory.append(keyword)
            }
            searchTableView.reloadData()
        } else {
            viewModel.searchedKeyword = ""
        }
    }
    
    @IBAction func backButtonTapped() {
        pop(animated: true, completion: nil)
    }
}

extension SRSearchViewController : UITableViewDelegate , UITableViewDataSource {
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
        let productListVC = SRProductListViewController(viewModel: SRProductListViewModel( title: SRAppContext.searchHistory[indexPath.row], pageTitle: SRAppContext.searchHistory[indexPath.row]))
        prompt(productListVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
}

extension SRSearchViewController : SearchTableViewCellDelegate {
    func deleteButtonTapped(title: String?) {
        for keyword in SRAppContext.searchHistory where keyword == title {
            let index = SRAppContext.searchHistory.firstIndex(of: keyword) ?? 0
            SRAppContext.searchHistory.remove(at: index)
        }
        self.searchTableView.reloadData()
    }
}
