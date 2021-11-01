//
//  ShoppingCardViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit

class ShoppingCartViewController: BaseViewController<ShoppingCartViewModel>, EmptyViewDelegate {
    

    @IBOutlet private weak var emptyView: EmptyView!
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var itemCountLabel: UILabel!
    
    @IBOutlet private weak var clearCartButton: UIButton!
    @IBOutlet private weak var campaignView: UIView!
    @IBOutlet private weak var campaignLabel: UILabel!
    
    @IBOutlet private weak var tableView: UITableView!
    
    @IBOutlet private weak var bottomPriceView: BottomPriceView!
    @IBOutlet private weak var checkoutButton: UIButton!
    

    init(viewModel: ShoppingCartViewModel){
        super.init(viewModel: viewModel, nibName: ShoppingCartViewController.nibName, bundle: Bundle(for: ShoppingCartViewController.self))
    }
    
    override func setup() {
        super.setup()
        getShoppingCart()
        
    }
    
    func configure() {
        if(viewModel.isShoppingCartEmpty()){
            containerView.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
            emptyView.delegate = self
        }else {
            containerView.isHidden = false
            emptyView.isHidden = true
            
            bottomPriceView.setup(model: viewModel.getBottomPriceModel())
            itemCountLabel.text = viewModel.getItemCountText()
            
            if(viewModel.hasCampaign()){
                campaignView.isHidden = false
                campaignLabel.text = viewModel.campaignMessage
            }else{
                campaignView.isHidden = true
            }
            
        }
    }
    
    private func getShoppingCart() {
        viewModel.getShoppingCart(success: {
            self.configure()
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    func actionButtonClicked(_ sender: Any) {
       popToRoot(animated: true, completion: nil)
    }
    
}
