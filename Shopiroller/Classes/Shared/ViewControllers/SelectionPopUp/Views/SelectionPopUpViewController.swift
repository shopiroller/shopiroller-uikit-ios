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
        static var cancelButtonText: String { return "selection-pop-up-cancel-button-text".localized }
        static var selectCountryTitle: String { return "selection-pop-up-country-text".localized }
        static var selectStateTitle: String { return "selection-pop-up-states-text".localized }
        static var selectDistrictTitle: String { return "selection-pop-up-district-text".localized }
    }

    @IBOutlet private weak var selectionPopUpTitle: UILabel!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var selectionTableView: UITableView!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var selectionPopUpView: UIView!
    
    var delegate: SelectionPopUpDelegate?
        
    init(viewModel: SelectionPopUpViewModel){
        super.init(viewModel: viewModel, nibName: SelectionPopUpViewController.nibName, bundle: Bundle(for: SelectionPopUpViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        selectionPopUpView.makeCardView()
        
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.register(cellClass: SelectionTableViewCell.self)
        selectionTableView.rowHeight = 50
        selectionTableView.separatorStyle = .none
        
        cancelButton.setTitle(Constants.cancelButtonText)
        cancelButton.setTitleColor(.textPrimary)
        cancelButton.titleLabel?.font = .semiBold16

        searchBar.delegate = self
        searchBar.setSearchBar(placeholder: Constants.searchText)
        
        viewModel.clearData()
        
        switch viewModel.getSelectionType() {
        case .COUNTRY:
            selectionPopUpTitle.text = Constants.selectCountryTitle
        case .STATE:
            selectionPopUpTitle.text = Constants.selectStateTitle
        case .DISTRICT:
            selectionPopUpTitle.text = Constants.selectDistrictTitle
        case .none:
            selectionPopUpTitle.text = Constants.selectCountryTitle
        }
        
        
    }
    
    @IBAction func cancelButtonTapped() {
        dismiss(animated: false, completion: nil)
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
    }
}
