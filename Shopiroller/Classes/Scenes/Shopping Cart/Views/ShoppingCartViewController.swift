//
//  ShoppingCardViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 1.11.2021.
//

import UIKit

class ShoppingCartViewController: BaseViewController<ShoppingCartViewModel>, EmptyViewDelegate {
    
    private struct Constants {
        
        static var clearCartButtonText : String { return "e_commerce_shopping_cart_clear_cart".localized }
        
        static var pageTitle: String { return "e_commerce_shopping_cart_title".localized }
        
        static var checkOutButtonText: String { return "e_commerce_shopping_cart_checkout_button".localized }
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
            } else {
                campaignView.isHidden = true
            }
            
            tableView.register(cellClass: ShoppingCartTableViewCell.self)
            tableView.register(cellClass: ShoppingCartTableViewCouponCell.self)
            viewModel.setDiscountCoupon(coupon: "e_commerce_shopping_cart_coupon_dialog_textfield_placeholder".localized)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return viewModel.shoppingItemCount()
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCell.reuseIdentifier, for: indexPath) as! ShoppingCartTableViewCell
            guard let model = viewModel.getShoppingCartItem(position: indexPath.row) else { return cell}
            cell.setup(model: model, self,index: indexPath.row,isLast: false)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartTableViewCouponCell.reuseIdentifier, for: indexPath) as! ShoppingCartTableViewCouponCell
            cell.setup(buttonText: viewModel.getDiscountCoupon())
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1) {
            let vc = PopUpViewViewController(viewModel: viewModel.getCouponPopUpViewModel())
            vc.delegate = self
            popUp(vc, completion: nil)
            print(indexPath)
        }
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
        if let popUpType = popUpViewController.viewModel.getType() {
            switch popUpType {
            case .inputPopUp:
                viewModel.setDiscountCoupon(coupon: popUpViewController.viewModel.getInputString())
                self.tableView.reloadData()
            case .normalPopUp:
                clearShoppingCart()
            }
        }
    }
}
