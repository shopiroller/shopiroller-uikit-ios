//
//  FilterSelectionViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.11.2021.
//

import UIKit
import Kingfisher

protocol FilterChoiceViewControllerDelegate {
    func choiceConfirmed(selectedIds: [String], selectionLabel: String)
}
class FilterChoiceViewController: BaseViewController<FilterChoiceViewModel> {
    
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let delegate: FilterChoiceViewControllerDelegate
    
    init(viewModel: FilterChoiceViewModel, delegate: FilterChoiceViewControllerDelegate) {
        self.delegate = delegate
        super.init(viewModel.title, viewModel: viewModel, nibName: FilterChoiceViewController.nibName, bundle: Bundle(for: FilterChoiceViewController.self))
    }

    override func setup() {
        super.setup()
        confirmButton.setTitleColor(.white)
        confirmButton.backgroundColor = .buttonPrimary
        confirmButton.setTitle("filter_choice_apply".localized)
        
        selectionTableView.register(cellClass: FilterChoiceTableViewCell.self)
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.allowsMultipleSelection = viewModel.isMultipleChoice
        selectionTableView.reloadData()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        delegate.choiceConfirmed(selectedIds: viewModel.getSelectedIds(), selectionLabel: viewModel.getSelectionNameLabel())
        pop(animated: true, completion: nil)
    }
    
}

extension FilterChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableViewListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterChoiceTableViewCell.reuseIdentifier, for: indexPath) as! FilterChoiceTableViewCell
        cell.setup(model: viewModel.getTableViewListItem(position: indexPath.row), isCheckBox: viewModel.isMultipleChoice)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(position: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        viewModel.didDeselectRow(position: indexPath.row)
    }
}
