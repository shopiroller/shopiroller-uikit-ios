//
//  FilterSelectionViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.11.2021.
//

import UIKit
import Kingfisher

protocol FilterChoiceViewControllerDelegate {
    func choiceConfirmed(selectedIds: SelectionIds)
}

class FilterChoiceViewController: BaseViewController<FilterChoiceViewModel> {
    
    @IBOutlet private weak var selectionTableView: UITableView!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private let delegate: FilterChoiceViewControllerDelegate
    
    init(viewModel: FilterChoiceViewModel, delegate: FilterChoiceViewControllerDelegate) {
        self.delegate = delegate
        super.init(viewModel.title, viewModel: viewModel, nibName: FilterChoiceViewController.nibName, bundle: Bundle(for: FilterChoiceViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        confirmButton.setTitleColor(.white)
        confirmButton.backgroundColor = .buttonPrimary
        confirmButton.setTitle("e_commerce_filter_selection_apply".localized)
        
        selectionTableView.register(cellClass: FilterChoiceTableViewCell.self)
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.allowsMultipleSelection = viewModel.isMultipleChoice
        selectionTableView.reloadData()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        if(viewModel.isMultipleChoice) {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchBar.delegate = self
            searchController.hidesNavigationBarDuringPresentation = false
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        delegate.choiceConfirmed(selectedIds: viewModel.getSelectedIds())
        pop(animated: true, completion: nil)
    }
    
}

extension FilterChoiceViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchList(text: searchBar.text)
        selectionTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.refreshList()
        selectionTableView.reloadData()
    }
}

extension FilterChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFilteredListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterChoiceTableViewCell.reuseIdentifier, for: indexPath) as! FilterChoiceTableViewCell
        cell.setup(model: viewModel.getFilteredListData(position: indexPath.row), isCheckBox: viewModel.isMultipleChoice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(viewModel.isFilteredListSelected(position: indexPath.row)) {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(position: indexPath.row)
        selectionTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.didDeselectRow(position: indexPath.row)
        selectionTableView.reloadData()
    }
}
