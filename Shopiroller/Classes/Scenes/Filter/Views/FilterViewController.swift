//
//  FilterViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

class FilterViewController: BaseViewController<FilterViewModel> {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    
    init(viewModel: FilterViewModel) {
        super.init("filter_title".localized, viewModel: viewModel, nibName: FilterViewController.nibName, bundle: Bundle(for: FilterViewController.self))
    }
    
    override func setup() {
        super.setup()
        getFilterOptions()
        
        confirmButton.setTitleColor(.white)
        confirmButton.backgroundColor = .buttonPrimary
        confirmButton.setTitle("filter_confirm".localized)
    }
    
    private func configureUI() {
        viewModel.configureTableList()
        filterTableView.register(cellClass: FilterVariationTableViewCell.self)
        filterTableView.register(cellClass: FilterPriceRangeTableViewCell.self)
        filterTableView.register(cellClass: FilterSwitchTableViewCell.self)
        filterTableView.delegate = self
        filterTableView.dataSource = self
        filterTableView.reloadData()
    }
    
    private func getFilterOptions() {
        viewModel.getFilterOptions(succes: {
            DispatchQueue.main.async {
                self.configureUI()
            }
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }

    @IBAction func confirmButtonTapped(_ sender: Any) {
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getFilterListSelectorCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getFilterListSelector(position: indexPath.row) {
        case .category:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterVariationTableViewCell.reuseIdentifier, for: indexPath) as! FilterVariationTableViewCell
            cell.setupCategory(selectionLabel: viewModel.getSelectionLabel())
            return cell
        case .brand:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterVariationTableViewCell.reuseIdentifier, for: indexPath) as! FilterVariationTableViewCell
            cell.setupBrand(selectionLabel: viewModel.getSelectionLabel())
            return cell
        case .variationGroups(position: let position):
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterVariationTableViewCell.reuseIdentifier, for: indexPath) as! FilterVariationTableViewCell
            if let item = viewModel.getVariationGroupsItem(position: position) {
                cell.setup(model: item, selectionLabel: viewModel.getSelectionLabel())
            }
            return cell
        case .priceRange:
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterPriceRangeTableViewCell.reuseIdentifier, for: indexPath) as! FilterPriceRangeTableViewCell
            cell.setup(currency: viewModel.getCurrency())
            return cell
        case .filterSwitch(type: let type):
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterSwitchTableViewCell.reuseIdentifier, for: indexPath) as! FilterSwitchTableViewCell
            cell.setup(type: type, delegate: self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedIndexPath = indexPath
        if let viewModel = viewModel.getFilterChoiceViewModel() {
            prompt(FilterChoiceViewController(viewModel: viewModel, delegate: self), animated: true, completion: nil)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FilterViewController: FilterSwitchTableViewCellDelegate, FilterChoiceViewControllerDelegate {
    func choiceConfirmed(selectedIds: [String], selectionLabel: String){
        viewModel.choiceConfirmed(selectedIds: selectedIds, selectionLabel: selectionLabel)
        filterTableView.reloadRows(at: [viewModel.selectedIndexPath], with: .automatic)
    }
    
    func checkedChanged(type: FilterSwitchType, checked: Bool) {
        
    }
}
