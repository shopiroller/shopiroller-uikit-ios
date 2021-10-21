//
//  OrderDetailViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 19.10.2021.
//

import UIKit

class OrderDetailViewController: BaseViewController<OrderDetailViewModel> {
    
    
    
    init(viewModel: OrderDetailViewModel){
        super.init(viewModel: viewModel, nibName: OrderDetailViewController.nibName, bundle: Bundle(for: OrderDetailViewController.self))
    }
    
    override func setup() {
        super.setup()
        
    
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
