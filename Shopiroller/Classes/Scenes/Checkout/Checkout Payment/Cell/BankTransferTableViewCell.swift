//
//  BankTransferTableViewCell.swift
//  Shopiroller
//
//  Created by Görkem Gür on 11.11.2021.
//

import UIKit

protocol BankTransferCellDelegate: AnyObject {
    
    func tappedCopyIbanButton()
}

class BankTransferTableViewCell: UITableViewCell {
   
    private struct Constants {
        
        static var accountIbanText: String { return "e_commerce_payment_bank_iban".localized }
        
        static var accountDepartmentText: String { return "e_commerce_payment_bank_branch".localized }
        
        static var accountNumberText: String { return "e_commerce_payment_bank_account".localized }
    }
    
    @IBOutlet private weak var ibanCopyButton: UIButton!
    @IBOutlet private weak var checkMarkIcon: UIImageView!
    @IBOutlet private weak var bankAccountTitle: UILabel!
    @IBOutlet private weak var bankAccountDescription: UILabel!
    @IBOutlet private weak var bankAccountIban: UILabel!
    @IBOutlet private weak var bankAccountDepartment: UILabel!
    @IBOutlet private weak var bankAccountNumber: UILabel!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var ibanCopyButtonContainer: UIView!
    
    private var indexAtRow: Int? = 0
    
    private var isClicked: Bool = false
    
    private var bankAccountIbanText: String? = ""
    
    weak var delegate : BankTransferCellDelegate?
    var model: BankAccountModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerView.layer.borderColor = UIColor.textPrimary.withAlphaComponent(0.1).cgColor
        containerView.layer.borderWidth = 1
        containerView.layer.cornerRadius = 6
        
        checkMarkIcon.image = .strokedCheckmark
        checkMarkIcon.tintColor = .textPrimary
        
        ibanCopyButton.setImage(.copyIcon)
        ibanCopyButton.tintColor = .textPrimary
        ibanCopyButton.layer.cornerRadius = ibanCopyButton.frame.width / 2
        ibanCopyButton.layer.backgroundColor = UIColor.buttonLight.cgColor
      
        
        bankAccountTitle.font = .semiBold14
        bankAccountTitle.textColor = .textPrimary
        
        bankAccountDescription.font = .regular12
        bankAccountDescription.textColor = .textPCaption
        
        bankAccountIban.font = .regular12
        bankAccountIban.textColor = .textPCaption
        
        bankAccountDepartment.font = .regular12
        bankAccountDescription.textColor = .textPCaption

        bankAccountNumber.font = .regular12
        bankAccountNumber.textColor = .textPCaption
        
    }
    
    func configureBankList(model : BankAccountModel?, index: Int?, isSelected: Bool) {
        self.model = model
        self.indexAtRow = index
        
        bankAccountTitle.text = model?.name
        
        if(model?.nameSurname != nil) {
            bankAccountDescription.text = model?.nameSurname
        } else {
            bankAccountDescription.isHidden = true
        }
        bankAccountIban.attributedText = String().makeBoldString(
            boldText: Constants.accountIbanText,
            normalText: model?.accountAddress,isReverse: false)
        bankAccountDepartment.attributedText = String().makeBoldString(
            boldText: Constants.accountDepartmentText,
            normalText: (model?.accountName ?? "") + " / " + (model?.accountCode ?? ""),
            isReverse: false)
        bankAccountDepartment.lineBreakMode = .byTruncatingTail
        bankAccountNumber.attributedText = String().makeBoldString(
            boldText: Constants.accountNumberText,
            normalText: model?.accountNumber,
            isReverse: false)
        if isSelected {
            setSelectedCell()
        } else {
            setUnSelectedCell()
        }
        
    }

    
    func setSelectedCell() {
        ibanCopyButtonContainer.isHidden = false
        checkMarkIcon.isHidden = false
        containerView.layer.borderColor = UIColor.textPrimary.cgColor
    }
    
    func setUnSelectedCell() {
        ibanCopyButtonContainer.isHidden = true
        checkMarkIcon.isHidden = true
        containerView.layer.borderColor = UIColor.textPrimary.withAlphaComponent(0.1).cgColor
    }
    
    @IBAction func ibanCopyButtonTapped() {
        UIPasteboard.general.string = model?.accountAddress
        delegate?.tappedCopyIbanButton()
    }
}
