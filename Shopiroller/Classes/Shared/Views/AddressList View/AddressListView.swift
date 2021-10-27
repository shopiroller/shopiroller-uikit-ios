//
//  AddressListView.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import UIKit

extension AddressListView : NibLoadable { }
class AddressListView: BaseView {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: EmptyView!
    
    func setup(text: UIColor){
        super.setup()
        setupFromNib()
            layer.backgroundColor = text.cgColor
        
    }

}
