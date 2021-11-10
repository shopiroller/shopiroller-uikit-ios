//
//  SelectionPopUpViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 7.11.2021.
//

import UIKit
import Foundation

protocol SelectionPopoUpDelegate {
    func getCountryName(name: String?, type: SelectionType?)
    func getCountryId(id: String?, type: SelectionType?)
}

class SelectionPopUpViewController: BaseViewController<SelectionPopUpViewModel> {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var selectionTableView: UITableView!
    
    var delegate: SelectionPopoUpDelegate?
        
    init(viewModel: SelectionPopUpViewModel){
        super.init(viewModel: viewModel, nibName: SelectionPopUpViewController.nibName, bundle: Bundle(for: SelectionPopUpViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        self.view.makeCardView()
        selectionTableView.delegate = self
        selectionTableView.dataSource = self
        selectionTableView.register(cellClass: SelectionTableViewCell.self)
        selectionTableView.rowHeight = 50
        selectionTableView.separatorStyle = .none
        
        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(popView))
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        view.addGestureRecognizer(dismissGesture)
        
    }
    
    @IBAction func textFieldEditingChanged(_ textField: UITextField) {
        if let searchText = textField.text , searchText != "" {
            viewModel.isSearching = true
            viewModel.filterContentForSearchText(searchText: searchText)
        } else {
            viewModel.isSearching = false
        }
        selectionTableView.reloadData()
    }
    
    
    @objc func popView() {
        pop(animated: false)
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
        cell.delegate = self
        return cell
    }
    
}

extension SelectionPopUpViewController: CellNameTapped {
    func getId(id: String?) {
        if let selectedId = id , id != "" {
            delegate?.getCountryId(id: selectedId, type: viewModel.getType())
        }
    }
    
    func getName(name: String?) {
        if let name = name, name != "" {
            delegate?.getCountryName(name: name, type: viewModel.getType())
            pop(animated: false)
        }
        
    }
    
}
