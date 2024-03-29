//
//  AddressListViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 27.10.2021.
//

import UIKit

class SRAddressListViewController: BaseViewController<SRAddressListViewModel> {

    @IBOutlet private weak var addressTable: UITableView!
    @IBOutlet private weak var emptyView: EmptyView!
    @IBOutlet private weak var addButton: UIButton!
    
    init(viewModel: SRAddressListViewModel){
        super.init(viewModel: viewModel, nibName: SRAddressListViewController.nibName, bundle: Bundle(for: SRAddressListViewController.self))
    }
    
    override func setup() {
        super.setup()
        getAddressList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateAddress), name: Notification.Name(SRAppConstants.UserDefaults.Notifications.userAddressListObserve), object: nil)
    }
    
    @objc func updateAddress() {
        getAddressList()
        self.view.layoutIfNeeded()
    }
    
    private func configure(isUpdate: Bool) {
        if(viewModel.isListEmpty()){
            addressTable.isHidden = true
            emptyView.isHidden = false
            emptyView.setup(model: viewModel.getEmptyModel())
        }else{
            addressTable.isHidden = false
            emptyView.isHidden = true
            if(!isUpdate){
                addressTable.register(cellClass: AddressTableViewCell.self)
                addressTable.delegate = self
                addressTable.dataSource = self
                addressTable.reloadData()
            }
        }
    }
    
    private func getAddressList() {
        viewModel.getAddressList(success: {
            self.configure(isUpdate: false)
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
    
    private func deleteAddress() {
        viewModel.deleteAddress(success: {
            guard let row = self.viewModel.selectedIndexPathRow else { return }
            self.addressTable.deleteRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
            self.view.makeToast(text: self.viewModel.state == .shipping ? "user_my_address_shipping_address_removed_message".localized : "user_my_address_billing_address_removed_message".localized)
            self.configure(isUpdate: true)
            self.getAddressList()
            self.addressTable.reloadData()
            self.view.layoutIfNeeded()
        }) { (errorViewModel) in
            self.view.makeToast(errorViewModel)
        }
    }
}

extension SRAddressListViewController: UITableViewDelegate, UITableViewDataSource, AddressTableViewCellDelegate {
    func deleteButtonClicked(indexPathRow: Int?) {
        viewModel.selectedIndexPathRow = indexPathRow
        deleteAddress()
    }
    
    func editButtonClicked(indexPathRow: Int?) {
        switch viewModel.state {
        case .billing:
            guard let model = viewModel.getBillingAddress(position: indexPathRow ?? 0) else { return }
            let vc = SRAddressBottomSheetViewController(viewModel: SRAddressBottomSheetViewModel(type: .billing,isEditing: true,userBillingAddress: model))
            vc.delegate = self
            self.sheet(vc)
        case .shipping:
            guard let model = viewModel.getShippingAddress(position: indexPathRow ?? 0) else { return }
            let vc = SRAddressBottomSheetViewController(viewModel: SRAddressBottomSheetViewModel(type: .shipping,isEditing: true,userShippingAddress: model))
            vc.delegate = self
            self.sheet(vc)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getListSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.reuseIdentifier, for: indexPath) as! AddressTableViewCell
        cell.delegate = self
        switch viewModel.state {
        case .shipping:
            guard let model = viewModel.getShippingAddress(position: indexPath.row) else { return cell}
            cell.setup(model: model, indexPathRow: indexPath.row)
        case .billing:
            guard let model = viewModel.getBillingAddress(position: indexPath.row) else { return cell}
            cell.setup(model: model, indexPathRow: indexPath.row)
        }
        
        return cell
    }
}

extension SRAddressListViewController: AddressBottomViewDelegate {
    func saveButtonTapped(userShippingAddressModel: UserShippingAddressModel?, userBillingAddressModel: UserBillingAdressModel?, defaultAddressModel: SRDefaultAddressModel?) {
        DispatchQueue.main.async {
            self.getAddressList()
            self.view.layoutIfNeeded()
        }
        self.view.makeToast(String(format: "address-bottom-view-address-saved-text".localized))
        dismiss(animated: true, completion: nil)
    }
    
    func closeButtonTapped() {
       dismiss(animated: true)
    }
    
}
