//
//  SelectionPopUpViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import UIKit
import Foundation

protocol SelectionControllerDelegate: AnyObject {
    func getCountryId(id: String?)
}

class SRSelectionViewController: BaseViewController<SRSelectionViewModel> {
    
    private struct Constants {
        static var searchText : String { return "selection-pop-up-search-placeholder".localized }
        static var selectCountryTitle: String { return "user_address_country".localized }
        static var selectStateTitle: String { return "user_address_city".localized }
        static var selectDistrictTitle: String { return "user_address_district".localized }
    }

    @IBOutlet private weak var selectionTableView: UITableView!
    @IBOutlet private weak var selectionPopUpView: UIView!
    
    weak var delegate: SelectionControllerDelegate?
        
    init(viewModel: SRSelectionViewModel) {
        super.init(viewModel: viewModel, nibName: SRSelectionViewController.nibName, bundle: Bundle(for: SRSelectionViewController.self))
    }
    
    override func setup() {
        super.setup()
        
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
        coloredAppearance.backgroundColor = ShopirollerApp.shared.theme.navigationBarTintColor
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

extension SRSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = viewModel.getCellModel(position: indexPath.row)
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SelectionTableViewCell.reuseIdentifier,
            for: indexPath) as! SelectionTableViewCell
        cell.configureCell(model: cellModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationItem.searchController?.dismiss(animated: false)
        self.dismiss(animated: false, completion: {
            self.delegate?.getCountryId(id: self.viewModel.getCountryId(position: indexPath.row))
        })
    }
}

extension SRSelectionViewController: UISearchBarDelegate {
    
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
