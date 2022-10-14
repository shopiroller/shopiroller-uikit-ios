//
//  ListPopUpViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

protocol ListPopUpAddressDelegate: AnyObject {
    func getBillingAddress(billingAddress: UserBillingAdressModel?)
    func getShippingAddress(shippingAddress: UserShippingAddressModel?)
}

protocol ListPopUpPaymentDelegate: AnyObject {
    func getSelectedPayment(payment: PaymentTypeEnum)
}

protocol ListPopUpSortDelegate: AnyObject {
    func getSelectedSortIndex(index: Int)
}

class SRListPopUpViewController: BaseViewController<SRListPopUpViewModel> {
    
    @IBOutlet private weak var popUpHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var popUpTitle: UILabel!
    @IBOutlet private weak var popUpImageView: UIImageView!
    @IBOutlet private weak var popUpImageViewBackground: UIView!
    @IBOutlet private weak var popUpTableView: UITableView!
    @IBOutlet private weak var shoppingCartDescription: UILabel!
    @IBOutlet private weak var shoppingCartDescriptionContainer: UIView!
    @IBOutlet private weak var shoppingCartInformation: UILabel!
    @IBOutlet private weak var shoppingCartInformationContainer: UIView!
    @IBOutlet private weak var popUpView: UIView!
    @IBOutlet private weak var buttonContainer: UIView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var backgroundView: UIView!
    
    weak var addressDelegate : ListPopUpAddressDelegate?
    
    weak var paymentDelegate: ListPopUpPaymentDelegate?
    
    weak var sortDelegate: ListPopUpSortDelegate?
    
    init(viewModel: SRListPopUpViewModel) {
        super.init(viewModel: viewModel, nibName: SRListPopUpViewController.nibName, bundle: Bundle(for: SRListPopUpViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        popUpView.makeCardView()
        
        self.backgroundView.backgroundColor = .black.withAlphaComponent(0.2)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(popView))
        self.backgroundView.addGestureRecognizer(tap)
        
        popUpImageViewBackground.backgroundColor = .white
        popUpImageViewBackground.layer.cornerRadius = popUpImageViewBackground.frame.width / 2
        popUpImageView.layer.backgroundColor = UIColor.badgeSecondary.cgColor
        popUpImageView.layer.cornerRadius = popUpImageView.frame.width / 2
        
        shoppingCartDescription.font = .semiBold14
        shoppingCartDescription.textColor = .textPCaption
        
        shoppingCartInformation.font = .semiBold12
        shoppingCartInformation.textColor = .orangeyRed
        
        popUpTableView.delegate = self
        popUpTableView.dataSource = self
        popUpTableView.register(cellClass: AddressSelectTableViewCell.self)
        popUpTableView.register(cellClass: PaymentTableViewCell.self)
        popUpTableView.register(cellClass: SortProductTableViewCell.self)
        popUpTableView.separatorInset = UIEdgeInsets.zero
        popUpTableView.tableFooterView = UIView()
        
        switch viewModel.getListType() {
        case .address:
            setUpForAddress()
        case .payment:
            setUpForPayment()
        case .sortList:
            setUpForSort()
        }
        
        var estimatedHeight = CGFloat(100 + (viewModel.getItemCount() * Int(viewModel.getItemHeight())))
        
        if estimatedHeight < 220 {
            estimatedHeight = 220
        }
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
            if estimatedHeight > self.popUpView.frame.size.height {
                let heightDifference = estimatedHeight - self.popUpView.frame.size.height
                self.popUpHeightConstraint.constant += heightDifference
                if self.popUpHeightConstraint.constant > self.popUpView.frame.size.height / 10 * 30 {
                    self.popUpHeightConstraint.constant = self.popUpView.frame.size.height / 10 * 20
                }
            }
        }
    }
    
    private func setUpForAddress() {
        switch viewModel.getAddressType() {
        case .billing:
            popUpImageView.image = .deliveryAddress
        case .shipping:
            popUpImageView.image = .billingAddressIcon
        }
        popUpTitle.text = "e_commerce_address_selection_address_shipping_popup_title".localized
        popUpTitle.font = .semiBold20
        popUpTitle.textColor = .black
    }
    
    private func setUpForPayment() {
        popUpImageView.image = .emptyPaymentMethod
        popUpTitle.text = "e_commerce_payment_method_selection_payment_type_popup_title".localized
        popUpTitle.font = .semiBold20
        popUpTitle.textColor = .black
    }
    
    private func setUpForShoppingCart() {
        popUpTitle.text = "e_commerce_order_summary_update_order_popup_button".localized
        popUpTitle.font = .bold24
        popUpTitle.textColor = .black
        shoppingCartDescriptionContainer.isHidden = false
        shoppingCartInformationContainer.isHidden = false
    }
    
    private func setUpForSort() {
        popUpImageView.image = .sortPopUpIcon
        popUpTitle.text = "e_commerce_category_product_list_order_dialog_title".localized
        popUpTitle.font = .semiBold20
        popUpTitle.textColor = .black
        popUpTableView.rowHeight = 60
    }
    
    @objc func popView() {
        pop(animated: false)
    }
    
}

extension SRListPopUpViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getListType() {
        case .address:
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            switch viewModel.getAddressType() {
            case .shipping:
                let model = viewModel.getShippingAddress(position: indexPath.row)
                let cell = tableView.dequeueReusableCell(withIdentifier: AddressSelectTableViewCell.reuseIdentifier, for: indexPath) as! AddressSelectTableViewCell
                cell.setupShippingCell(
                    model: model,
                    showDivider: self.viewModel.getItemCount() - 1 != indexPath.row)
                if indexPath.row == viewModel.getItemCount() - 1 {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
                }
                return cell
            case .billing:
                let model = viewModel.getBillingAddress(position: indexPath.row)
                let cell = tableView.dequeueReusableCell(withIdentifier: AddressSelectTableViewCell.reuseIdentifier, for: indexPath) as! AddressSelectTableViewCell
                cell.setupBillingCell(
                    model: model,
                    showDivider: self.viewModel.getItemCount() - 1 != indexPath.row)
                return cell
            }
        case .payment:
            let model = viewModel.getSupportedMethods(position: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.reuseIdentifier, for: indexPath) as! PaymentTableViewCell
            cell.setupCell(model: model,index: indexPath.row)
            return cell
        case .sortList :
            let title = viewModel.getSortListModel(position: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: SortProductTableViewCell.reuseIdentifier, for: indexPath) as! SortProductTableViewCell
            cell.setup(
                title: title,
                isChecked: viewModel.sortOptionsSelectedIndex == indexPath.row,
                index: indexPath.row)
            if indexPath.row == viewModel.getItemCount() - 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
            }
            return cell
        }
        return UITableViewCell()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.getListType() {
        case .address:
            tableView.tableFooterView = UIView()
            tableView.separatorStyle = .none
            switch viewModel.getAddressType() {
            case .shipping:
                addressDelegate?.getShippingAddress(
                    shippingAddress: viewModel.getShippingAddress(position: indexPath.row))
            case .billing:
                addressDelegate?.getBillingAddress(
                    billingAddress: viewModel.getBillingAddress(position: indexPath.row))
            }
        case .payment:
            guard let supportedPaymentMethods = viewModel.getSupportedMethods(position: indexPath.row) else { return }
            paymentDelegate?.getSelectedPayment(payment: supportedPaymentMethods.paymentType)
        case .sortList :
            viewModel.sortOptionsSelectedIndex = indexPath.row
            sortDelegate?.getSelectedSortIndex(index: viewModel.sortOptionsSelectedIndex ?? 0)
        }
        self.popView()
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
}

