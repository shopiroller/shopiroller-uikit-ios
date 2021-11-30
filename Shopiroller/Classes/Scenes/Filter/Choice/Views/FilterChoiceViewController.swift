//
//  FilterSelectionViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 25.11.2021.
//

import UIKit

protocol FilterChoiceViewControllerDelegate {
    func choiceConfirmed(selectedItem: CategoriesItem?)
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
    }
    
}

extension FilterChoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getDataListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilterChoiceTableViewCell.reuseIdentifier, for: indexPath) as! FilterChoiceTableViewCell
        cell.setup(name: "filter_choice_apply")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
