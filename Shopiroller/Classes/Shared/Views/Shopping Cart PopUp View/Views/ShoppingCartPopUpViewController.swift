//
//  ShoppingCartPopUpViewController.swift
//  Shopiroller
//
//  Created by abdllhyalcn on 3.11.2021.
//

import UIKit
import Kingfisher

protocol ShoppingCartPopUpViewControllerDelegate: ShoppingCartPopUpTableViewCellDelegate {
    func readyToCheckoutClicked(_ sender: Any)
}

class ShoppingCartPopUpViewController: BaseViewController<ShoppingCartPopUpViewModel> {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkoutButton: UIButton!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    private let delegate: ShoppingCartPopUpViewControllerDelegate
    
    init(viewModel: ShoppingCartPopUpViewModel, delegate: ShoppingCartPopUpViewControllerDelegate){
        self.delegate = delegate
        super.init(viewModel: viewModel, nibName: ShoppingCartPopUpViewController.nibName, bundle: Bundle(for: ShoppingCartPopUpViewController.self))
    }

    override func setup() {
        super.setup()
        
        titleLabel.textColor = .textPrimary
        descriptionLabel.textColor = .textPCaption
        warningLabel.textColor = .orangeyRed
        
        containerView.layer.cornerRadius = 6
        checkoutButton.backgroundColor = .textPrimary
        checkoutButton.tintColor = .white
        checkoutButton.layer.cornerRadius = 6
        
        titleLabel.text = viewModel.getTitle()
        descriptionLabel.text = viewModel.getDescription()
        warningLabel.text = viewModel.getWarning()
        checkoutButton.setTitle(viewModel.getButtonTitle())
        
        tableViewHeight.constant = viewModel.getTableViewMultiplier()
        tableView.register(cellClass: ShoppingCartPopUpTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
    
    @IBAction func readyToCheckoutClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate.readyToCheckoutClicked(sender)
    }
    
}

extension ShoppingCartPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getProductListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingCartPopUpTableViewCell.reuseIdentifier, for: indexPath) as! ShoppingCartPopUpTableViewCell
        
        guard let model = viewModel.getProduct(position: indexPath.row) else { return cell}
        cell.setup(model: model, delegate: delegate)
        
        return cell
    }
}
