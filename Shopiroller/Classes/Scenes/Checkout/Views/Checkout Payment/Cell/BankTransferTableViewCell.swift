//
//  BankTransferTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 11.11.2021.
//

import UIKit

class BankTransferTableViewCell: UITableViewCell {
   
    private struct Constants {
        static var accountIbanText: String { return "checkout-table-view-account-iban-text".localized }
        static var accountDepartmentText: String { return "checkout-table-view-account-department-text".localized }
        static var accountNumberText: String { return "checkout-table-view-account-number-text".localized }
    }
    
    @IBOutlet private weak var ibanCopyButton: UIButton!
    @IBOutlet private weak var checkMarkIcon: UIImageView!
    @IBOutlet private weak var bankAccountTitle: UILabel!
    @IBOutlet private weak var bankAccountDescription: UILabel!
    @IBOutlet private weak var bankAccountIban: UILabel!
    @IBOutlet private weak var bankAccountDepartment: UILabel!
    @IBOutlet private weak var bankAccountNumber: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bankAccountTitle.font = UIFont.boldSystemFont(ofSize: 14)
        bankAccountTitle.textColor = .textPrimary
        
        bankAccountDescription.font = UIFont.boldSystemFont(ofSize: 12)
        bankAccountDescription.textColor = .textPCaption
        
        bankAccountIban.font = UIFont.boldSystemFont(ofSize: 12)
        bankAccountIban.textColor = .textPCaption
        
        bankAccountDepartment.font = UIFont.boldSystemFont(ofSize: 12)
        bankAccountDescription.textColor = .textPCaption

        bankAccountNumber.font = UIFont.boldSystemFont(ofSize: 12)
        bankAccountNumber.textColor = .textPCaption
    }
    
    func configureBankList(model : BankAccountModel?) {
        if let nameSurname = model?.nameSurname {
            bankAccountDescription.text = nameSurname
        } else {
            bankAccountDescription.isHidden = true
            bankAccountTitle.text = model?.name
            bankAccountIban.attributedText = Constants.accountIbanText.makeBoldAfterString(normalText: model?.accountAdress)
            bankAccountDepartment.attributedText = Constants.accountDepartmentText.makeBoldAfterString(normalText: "\(model?.accountName) / \(model?.accountCode)")
            bankAccountNumber.attributedText = Constants.accountNumberText.makeBoldAfterString(normalText: model?.accountNumber)
        }
        
    }
    
}
