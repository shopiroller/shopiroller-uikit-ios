//
//  ShoppingCardViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit

class ShoppingCartViewController: BaseViewController<ShoppingCartViewModel>, EmptyViewDelegate {
    
    private struct Constants {
        
        static var clearCartButtonText : String { return "shopping_cart_clear_cart_button_text".localized }
        
        static var pageTitle: String { return "shopping_cart_title".localized }
        
        static var checkOutButtonText: String { return "shopping_cart_validate_proceed_checkout".localized }
    }
    

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
        super.init(Constants.pageTitle, viewModel: viewModel, nibName: ShoppingCartViewController.nibName, bundle: Bundle(for: ShoppingCartViewController.self))
    }
    
    override func setup() {
        super.setup()
        getShoppingCart()
        
        itemCountLabel.textColor = .textPCaption
        itemCountLabel.font = .regular12
        
        clearCartButton.tintColor = .textSecondary
        clearCartButton.setTitle(Constants.clearCartButtonText)
        clearCartButton.titleLabel?.font = .regular12
        
        campaignView.backgroundColor = .buttonLight
        campaignLabel.textColor = .textPrimary
        campaignLabel.font = .regular12
        
        checkoutButton.setTitle(Constants.checkOutButtonText)
        checkoutButton.titleLabel?.font = .semiBold15
        checkoutButton.setTitleColor(.white)
        
        tableView.tableFooterView = UIView()
    }
    
    override func setupNavigationBar() {
        super.setupNavigationBar()
        updateNavigationBar(rightBarButtonItems: nil, isBackButtonActive: true)
        navigationController?.navigationBar.backgroundColor = ShopirollerApp.shared.theme.navigationBarTintColor
        navigationController?.navigationBar.barTintColor = ShopirollerApp.shared.theme.navigationBarTintColor
    }
    
    func configure() {
        if(viewModel.isShoppingCartEmpty()) {
            containerView.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
            emptyView.delegate = self
        } else {
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
            
            showIfHasInvalidItem()
        }
    }
    
    private func getShoppingCart() {
        viewModel.getShoppingCart(success: {
            self.configure()
            self.showIfHasInvalidItem()
        }) { (errorViewModel) in
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func clearShoppingCart() {
        viewModel.clearShoppingCart(success: {
            self.configure()
        }) { (errorViewModel) in
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func removeItemFromShoppingCart(itemId: String?) {
        viewModel.removeItemFromShoppingCart(itemId: itemId, success: {
            self.tableView.deleteRows(at: [IndexPath(row: self.viewModel.indexAtRow ?? 0, section: 0)], with: .left)
            self.configure()
        }) { (errorViewModel) in
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func updateItemQuantity(itemId: String?, quantity: Int?) {
        viewModel.updateItemQuantity(itemId: itemId, quantity: quantity, success: {
            self.configure()
        }) { (errorViewModel) in
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func validateShoppingCart() {
        viewModel.validateShoppingCart(success: {
            self.configure()
        }) { (errorViewModel) in
            self.showAlertError(viewModel: errorViewModel)
        }
    }
    
    private func showIfHasInvalidItem() {
        if(viewModel.hasInvalidItems()){
            let vc = ShoppingCartPopUpViewController(viewModel: viewModel.geShoppingCartPopUpViewModel(), delegate: self)
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
    
    @IBAction func proceedToCheckoutClicked(_ sender: Any) {
        if(!viewModel.hasInvalidItems()){
            let checkOutViewController = CheckOutViewController(viewModel: CheckOutViewModel())
            prompt(checkOutViewController, animated: true, completion: nil)
        } else {
            showIfHasInvalidItem()
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(false)
    }
    
}

extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.shoppingItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier, for: indexPath) as! ShoppingCartTableViewCell
        guard let model = viewModel.getShoppingCartItem(position: indexPath.row) else { return cell}
        cell.setup(model: model, self,index: indexPath.row,isLast: self.viewModel.shoppingItemCount() - 1 == indexPath.row)
        return cell
    }
}

extension ShoppingCartViewController: ShoppingCartTableViewCellDelegate, ShoppingCartPopUpViewControllerDelegate {
    
    func readyToCheckoutClicked(_ sender: Any) {
        validateShoppingCart()
    }
    
    func updateQuantityClicked(itemId: String?, quantity: Int) {
        updateItemQuantity(itemId: itemId, quantity: quantity)
    }
    
    func deleteClicked(itemId: String?,index: Int?) {
        viewModel.indexAtRow = index
        removeItemFromShoppingCart(itemId: itemId)
    }
    
}


extension ShoppingCartViewController: PopUpViewViewControllerDelegate {
    
    func firstButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController) {}
    
    func secondButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController) {
        clearShoppingCart()
    }
    
}
