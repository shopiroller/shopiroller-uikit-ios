//
//  ListPopUpViewController.swift
//  Shopiroller
//
//  Created by Görkem Gür on 9.11.2021.
//

import UIKit

protocol ListPopUpAddressDelegate {
    func getBillingAddress(billingAddress: UserBillingAdressModel?)
    func getShippingAddress(shippingAddress: UserShippingAddressModel?)
}

protocol ListPopUpPaymentDelegate {
    func getSelectedPayment(payment: PaymentTypeEnum)
}

protocol ListPopUpSortDelegate {
    func getSelectedSortIndex(index: Int)
}

class ListPopUpViewController: BaseViewController<ListPopUpViewModel> {
    
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
    
    var addressDelegate : ListPopUpAddressDelegate?
    
    var paymentDelegate: ListPopUpPaymentDelegate?
    
    var sortDelegate: ListPopUpSortDelegate?
    
    override func setup() {
        super.setup()
        
        popUpView.makeCardView()
        
        popUpImageViewBackground.backgroundColor = .white
        popUpImageViewBackground.layer.cornerRadius = popUpImageViewBackground.frame.width / 2
        popUpImageView.layer.backgroundColor = UIColor.badgeSecondary.cgColor
        popUpImageView.layer.cornerRadius = popUpImageView.frame.width / 2
        
        shoppingCartDescription.font = .semiBold14
        shoppingCartDescription.textColor = .textPCaption
        
        shoppingCartInformation.font = .semiBold12
        shoppingCartInformation.textColor = .orangeyRed
        
        popUpTableView.register(cellClass: AddressSelectTableViewCell.self)
        popUpTableView.register(cellClass: PaymentTableViewCell.self)
        popUpTableView.register(cellClass: SortProductTableViewCell.self)
        popUpTableView.separatorInset = UIEdgeInsets.zero
        popUpTableView.delegate = self
        popUpTableView.dataSource = self
        popUpTableView.tableFooterView = UIView()

        
        let dismissGesture = UITapGestureRecognizer(target: self, action: #selector(popView))
        self.view.backgroundColor = .black.withAlphaComponent(0.2)
        view.addGestureRecognizer(dismissGesture)
        
        switch viewModel.getListType(){
        case .address:
            setUpForAddress()
        case .payment:
            setUpForPayment()
        case .shoppingCart:
            setUpForAddress()
        case .sortList:
            setUpForSort()
        }
        
    }
    
    init(viewModel: ListPopUpViewModel){
        super.init(viewModel: viewModel, nibName: ListPopUpViewController.nibName, bundle: Bundle(for: ListPopUpViewController.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var estimatedHeight = CGFloat(100 + (viewModel.getItemCount() * Int(viewModel.getItemHeight())))
        
        if estimatedHeight < 220 {
            estimatedHeight = 220
        }
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.07) {
            if estimatedHeight > self.popUpView.frame.size.height {
                let heightDifference = estimatedHeight - self.popUpView.frame.size.height
                self.popUpHeightConstraint.constant += heightDifference
                
                if self.popUpHeightConstraint.constant > self.view.frame.height / 10 * 65 {
                    self.popUpHeightConstraint.constant = self.view.frame.height / 10 * 65
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
        popUpTitle.text = "list-popup-select-address-title".localized
        popUpTitle.font = .semiBold20
        popUpTitle.textColor = .black
    }
    
    private func setUpForPayment() {
        popUpImageView.image = .emptyPaymentMethod
        popUpTitle.text = "list-popup-select-payment-title".localized
        popUpTitle.font = .semiBold20
        popUpTitle.textColor = .black
    }
    
    private func setUpForShoppingCart() {
        popUpTitle.text = "list-popup-shopping-cart-title".localized
        popUpTitle.font = .bold24
        popUpTitle.textColor = .black
        shoppingCartDescriptionContainer.isHidden = false
        shoppingCartInformationContainer.isHidden = false
    }
    
    private func setUpForSort() {
        popUpImageView.image = .sortPopUpIcon
        popUpTitle.text = "sort_dialog_title".localized
        popUpTitle.font = .semiBold20
        popUpTitle.textColor = .black
        popUpTableView.rowHeight = 60
    }
    
    @objc func popView() {
        pop(animated: false)
    }
    
}

extension ListPopUpViewController : UITableViewDelegate, UITableViewDataSource {
    
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
                cell.setupShippingCell(model: model,index: indexPath.row,showDivider: self.viewModel.getItemCount() - 1 != indexPath.row)
                cell.delegate = self
                if indexPath.row == viewModel.getItemCount() - 1 {
                    cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
                }
                return cell
            case .billing:
                let model = viewModel.getBillingAddress(position: indexPath.row)
                let cell = tableView.dequeueReusableCell(withIdentifier: AddressSelectTableViewCell.reuseIdentifier, for: indexPath) as! AddressSelectTableViewCell
                cell.setupBillingCell(model: model,index: indexPath.row, showDivider: self.viewModel.getItemCount() - 1 != indexPath.row)
                cell.delegate = self
                return cell
            }
        case .shoppingCart:
            break
        case .payment:
            let model = viewModel.getSupportedMethods(position: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentTableViewCell.reuseIdentifier, for: indexPath) as! PaymentTableViewCell
            cell.setupCell(model: model,index: indexPath.row)
            cell.delegate = self
            return cell
        case .sortList :
            let title = viewModel.getSortListModel(position: indexPath.row)
            let cell = tableView.dequeueReusableCell(withIdentifier: SortProductTableViewCell.reuseIdentifier, for: indexPath) as! SortProductTableViewCell
            cell.setup(title: title, isChecked: viewModel.selectedIndex == indexPath.row,index: indexPath.row)
            if indexPath.row == viewModel.getItemCount() - 1 {
                cell.separatorInset = UIEdgeInsets(top: 0, left: 400, bottom: 0, right: 0)
            }
            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
}

extension ListPopUpViewController: AddressPopUpSelectedDelegate {
    func getIndex(shippingAddressIndex: Int?, billingAddressIndex: Int?) {
        if let shippingAddressIndex = shippingAddressIndex {
            addressDelegate?.getShippingAddress(shippingAddress: viewModel.getShippingAddress(position: shippingAddressIndex))
            self.popView()
        }
        if let billingAddressIndex = billingAddressIndex {
            addressDelegate?.getBillingAddress(billingAddress: viewModel.getBillingAddress(position: billingAddressIndex))
            self.popView()
        }
    }
}

extension ListPopUpViewController: PaymentTableViewCellDelegate {
    func getPaymentIndex(index: Int?) {
        if let paymentType = viewModel.getSupportedMethods(position: index ?? 0)?.paymentType {
            paymentDelegate?.getSelectedPayment(payment: paymentType)
            self.popView()
        }
      
    }
}

extension ListPopUpViewController: SortProductCellDelegate {
    func getTappedIndex(index: Int) {
        viewModel.selectedIndex = index
        sortDelegate?.getSelectedSortIndex(index: viewModel.selectedIndex ?? 0)
        pop(animated: false, completion: nil)
    }
}

