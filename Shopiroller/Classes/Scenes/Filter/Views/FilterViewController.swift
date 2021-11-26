//
//  FilterViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 23.11.2021.
//

import UIKit

class FilterViewController: BaseViewController<FilterViewModel> {

    @IBOutlet weak var filterTableView: UITableView!
    
    init() {
        super.init("filter_title".localized, viewModel: FilterViewModel(), nibName: FilterViewController.nibName, bundle: Bundle(for: FilterViewController.self))
    }
    
    override func setup() {
        super.setup()
        
    }

}
