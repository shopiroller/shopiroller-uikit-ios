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
        super.init("shopping_cart_title".localized, viewModel: viewModel, nibName: ShoppingCartViewController.nibName, bundle: Bundle(for: ShoppingCartViewController.self))
    }
    
    override func setup() {
        super.setup()
        getShoppingCart()
        
        itemCountLabel.textColor = .textPCaption
        clearCartButton.tintColor = .textPrimary
        
        campaignView.backgroundColor = .buttonLight
        campaignLabel.textColor = .textPrimary
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
            
            tableView.register(cellClass: ShoppingCartTableViewCell.self)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.reloadData()
            
            checkInvalidation()
        }
    }
    
    private func getShoppingCart() {
        viewModel.getShoppingCart(success: {
            self.configure()
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func clearShoppingCart() {
        viewModel.clearShoppingCart(success: {
            self.configure()
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func removeItemFromShoppingCart(itemId: String?) {
        viewModel.removeItemFromShoppingCart(itemId: itemId, success: {
            self.configure()
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func updateItemQuantity(itemId: String?, quantity: Int?) {
        viewModel.updateItemQuantity(itemId: itemId, quantity: quantity, success: {
            self.configure()
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func checkInvalidation() {
        if(viewModel.hasInvalidItems()){
            let vc = ShoppingCartPopUpViewController(viewModel: viewModel.geShoppingCartPopUpViewModel())
          //  vc.delegate = self
            popUp(vc, completion: nil)
        }
    }
    
    func actionButtonClicked(_ sender: Any) {
       popToRoot(animated: true, completion: nil)
    }
    
    @IBAction func clearCartButtonClicked(_ sender: Any) {
        let vc = PopUpViewViewController(viewModel: viewModel.getClearCartPopUpViewModel())
        vc.delegate = self
        popUp(vc, completion: nil)
    }
    
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shopingItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        
        guard let model = viewModel.getShoppingCartItem(position: indexPath.row) else { return cell}
        cell.setup(model: model, self)
        
        return cell
    }
}

extension ShoppingCartViewController: ShoppingCartTableViewCellDelegate {
    func updateQuantityClicked(itemId: String?, quantity: Int) {
        updateItemQuantity(itemId: itemId, quantity: quantity)
    }
    
    func deleteClicked(itemId: String?) {
        removeItemFromShoppingCart(itemId: itemId)
    }
    
}


extension ShoppingCartViewController: PopUpViewViewControllerDelegate {
    func firstButtonClicked(_ sender: Any) {
        
    }
    
    func secondButtonClicked(_ sender: Any) {
        clearShoppingCart()
    }
    
}
