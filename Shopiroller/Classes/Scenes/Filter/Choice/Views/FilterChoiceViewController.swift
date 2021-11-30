//
//  FilterSelectionViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.11.2021.
//

import UIKit
import Kingfisher

protocol FilterChoiceViewControllerDelegate {
    func choiceConfirmed(selectedItem: FilterChoiceTableViewModel?)
}
class FilterChoiceViewController: BaseViewController<FilterChoiceViewModel> {
    
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
    
    private let delegate: FilterChoiceViewControllerDelegate
    
    init(viewModel: FilterChoiceViewModel, delegate: FilterChoiceViewControllerDelegate) {
        self.delegate = delegate
        super.init("filter_category".localized, viewModel: viewModel, nibName: FilterChoiceViewController.nibName, bundle: Bundle(for: FilterChoiceViewController.self))
    }

    override func setup() {
        super.setup()
        confirmButton.setTitleColor(.white)
        confirmButton.backgroundColor = .buttonPrimary
        confirmButton.setTitle("filter_choice_apply".localized)
        
        selectionTableView.register(cellClass: FilterChoiceTableViewCell.self)
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.reloadData()
    }
    
    @IBAction func confirmButtonTapped(_ sender: Any) {
        if(viewModel.isValid()) {
            delegate.choiceConfirmed(selectedItem: viewModel.getSelectedFilterChoiceTableViewModel())
            pop(animated: true, completion: nil)
        } else {
            view.makeToast("filter_choice_validation".localized)
        }
    }
    
}

extension FilterChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getTableViewListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterChoiceTableViewCell.reuseIdentifier, for: indexPath) as! FilterChoiceTableViewCell
        cell.setup(model: viewModel.getTableViewListItem(position: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let indexPath = viewModel.selectedIndexPath {
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        viewModel.selectedIndexPath = indexPath
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
