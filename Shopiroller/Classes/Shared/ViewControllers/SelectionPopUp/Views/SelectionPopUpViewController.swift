//
//  SelectionPopUpViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import UIKit
import Foundation

protocol SelectionPopUpDelegate {
    func getCountryId(id: String?)
}

class SelectionPopUpViewController: BaseViewController<SelectionPopUpViewModel> {
    
    private struct Constants {
        static var searchText : String { return "selection-pop-up-search-placeholder".localized }
        static var selectCountryTitle: String { return "selection-pop-up-country-text".localized }
        static var selectStateTitle: String { return "selection-pop-up-states-text".localized }
        static var selectDistrictTitle: String { return "selection-pop-up-district-text".localized }
    }

    @IBOutlet private weak var selectionTableView: UITableView!
    @IBOutlet private weak var selectionPopUpView: UIView!
    
    var delegate: SelectionPopUpDelegate?
        
    init(viewModel: SelectionPopUpViewModel){
        super.init(viewModel: viewModel, nibName: SelectionPopUpViewController.nibName, bundle: Bundle(for: SelectionPopUpViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        selectionPopUpView.makeCardView()
        
        self.navigationController?.navigationBar.isHidden = false
        
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.register(cellClass: SelectionTableViewCell.self)
        selectionTableView.separatorStyle = .none
        
        viewModel.clearData()
        
        switch viewModel.getSelectionType() {
        case .adress(addressType: .country):
            self.title = Constants.selectCountryTitle
        case .adress(addressType: .district):
            self.title = Constants.selectDistrictTitle
        case .adress(addressType: .state):
            self.title = Constants.selectStateTitle
        case .variant:
            break
        case .none:
            break
        }
        
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.backgroundColor = .iceBlue
        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.showsCancelButton = true
        navigationItem.searchController = searchController
    }
    
}

extension SelectionPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.getCellModel(position: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.reuseIdentifier, for: indexPath) as! SelectionTableViewCell
        cell.configureCell(model: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: false, completion: {
            self.delegate?.getCountryId(id: self.viewModel.getCountryId(position: indexPath.row))
        })
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .iceBlue
    }
    
}

extension SelectionPopUpViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
        viewModel.filterContentForSearchText()
        selectionTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearData()
        selectionTableView.reloadData()
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
