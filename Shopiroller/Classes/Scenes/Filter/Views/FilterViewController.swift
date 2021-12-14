//
//  FilterViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

protocol FilterViewControllerDelegate {
    func confirmedFilter(model: FilterModel)
}

class FilterViewController: BaseViewController<FilterViewModel> {

    @IBOutlet private weak var filterTableView: UITableView!
    @IBOutlet private weak var confirmButton: UIButton!
    
    private let delegate: FilterViewControllerDelegate
    
    init(viewModel: FilterViewModel, delegate: FilterViewControllerDelegate) {
        self.delegate = delegate
        super.init("filter_title".localized, viewModel: viewModel, nibName: FilterViewController.nibName, bundle: Bundle(for: FilterViewController.self))
    }
    
    override func setup() {
        super.setup()
        getFilterOptions()
        
        confirmButton.setTitleColor(.white)
        confirmButton.backgroundColor = .buttonPrimary
        confirmButton.setTitle("filter_confirm".localized)
        confirmButton.titleLabel?.font = .semiBold16
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        let clearButton = UIBarButtonItem.init(title: "filter_remove".localized, style: .done, target: self, action: #selector(clearButtonTapped))
        updateNavigationBar(rightBarButtonItems: [clearButton], isBackButtonActive: true)
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
        delegate.confirmedFilter(model: viewModel.selectedModel)
        pop(animated: true, completion: nil)
    }
    
    @objc func clearButtonTapped() {
        viewModel.clearFilter()
        filterTableView.reloadData()
        delegate.confirmedFilter(model: viewModel.selectedModel)
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
            cell.setup(delegate: self, currency: viewModel.getCurrency(), minPrice: viewModel.getMinPrice(), maxPrice: viewModel.getMaxPrice())
            return cell
        case .filterSwitch(type: let type):
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterSwitchTableViewCell.reuseIdentifier, for: indexPath) as! FilterSwitchTableViewCell
            cell.setup(type: type, delegate: self, isOn: viewModel.getSelectedSwitchState(type: type))
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

extension FilterViewController: FilterSwitchTableViewCellDelegate, FilterChoiceViewControllerDelegate, FilterPriceRangeTableViewCellDelegate {
    
    func choiceConfirmed(selectedIds: SelectionIds){
        viewModel.choiceConfirmed(selectedIds: selectedIds)
        filterTableView.reloadRows(at: [viewModel.selectedIndexPath], with: .automatic)
    }
    
    func minPriceDidEndEditing(amount: Double?) {
        viewModel.selectedModel.minimumPrice = amount
    }
    
    func maxPriceDidEndEditing(amount: Double?) {
        viewModel.selectedModel.maximumPrice = amount
    }
    
    func checkedChanged(type: FilterSwitchType, isOn: Bool) {
        viewModel.setSelectedSwitchState(type: type, isOn: isOn)
    }
    
}
