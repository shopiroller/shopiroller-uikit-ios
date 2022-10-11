//
//  PopUpViewViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import UIKit
import Kingfisher


protocol PopUpViewViewControllerDelegate: AnyObject {
    func firstButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController)
    func secondButtonClicked(_ sender: Any, popUpViewController: PopUpViewViewController)
}

class PopUpViewViewController: BaseViewController<PopUpViewModel> {
    
    @IBOutlet private weak var circleImageBackground: UIView!
    @IBOutlet private weak var circleImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var firstButton: SRButton!
    @IBOutlet private weak var secondButton: SRButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var firstButtonContainerView: UIView!
    @IBOutlet private weak var secondButtonContainerView: UIView!
    @IBOutlet private weak var popUpHeightContstraint: NSLayoutConstraint!
    @IBOutlet private weak var descriptionContainerView: UIView!
    @IBOutlet private weak var inputContainerView: UIView!
    @IBOutlet private weak var inputTextField: UITextField!
    
    weak var delegate: PopUpViewViewControllerDelegate?
    
    public init(viewModel: PopUpViewModel) {
        super.init(viewModel: viewModel, nibName: PopUpViewViewController.nibName, bundle: Bundle(for: PopUpViewViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        switch viewModel.getType() {
        case .normalPopUp:
            descriptionContainerView.isHidden = false
            inputContainerView.isHidden = true
        case .inputPopUp:
            descriptionContainerView.isHidden = true
            inputContainerView.isHidden = false
        case .none:
            inputContainerView.isHidden = true
        }
        
        
        inputTextField.text = viewModel.getInputString()
        inputTextField.textColor = .textSecondary30
        inputTextField.font = .regular12
        inputTextField.borderStyle = .none
        inputTextField.delegate = self
        inputTextField.backgroundColor = .buttonLight
        inputTextField.layer.cornerRadius = 6
        inputTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: inputTextField.frame.height))
        inputTextField.leftViewMode = .always
        
        circleImageBackground.backgroundColor = .white
        circleImageBackground.layer.cornerRadius = circleImageBackground.frame.width / 2
        circleImage.layer.backgroundColor = UIColor.badgeSecondary.cgColor
        circleImage.layer.cornerRadius = circleImage.frame.width / 2
        
        containerView.makeCardView()
        
        descriptionLabel.textColor = .textPCaption
        descriptionLabel.font = .regular14
        
        titleLabel.textColor = .textPrimary
        titleLabel.font = .bold24
        titleLabel.text = viewModel.getTitle()
        
        circleImage.image = viewModel.getImage()
        
        if (viewModel.hasFirstButton()) {
            firstButtonContainerView.isHidden = false
            firstButton.type = viewModel.getFirstButtonType()
            firstButton.setTitle(viewModel.getFirstButtonTitle())
            firstButton.titleLabel?.font = .semiBold14
            popUpHeightContstraint.constant += (firstButtonContainerView.frame.height)
        } else {
            firstButtonContainerView.isHidden = true
        }
        
        if (viewModel.hasSecondButton()) {
            secondButtonContainerView.isHidden = false
            secondButton.type = viewModel.getSecondButtonType()
            secondButton.setTitle(viewModel.getSecondButtonTitle())
            popUpHeightContstraint.constant += (firstButtonContainerView.frame.height * 2)
        } else {
            secondButtonContainerView.isHidden = true
        }
        
        if let htmlDescription = viewModel.getHtmlDescription() {
            let description = NSMutableAttributedString(attributedString: htmlDescription)
            let myParagraphStyle = NSMutableParagraphStyle()
            myParagraphStyle.alignment = .center
            description.addAttributes([.paragraphStyle: myParagraphStyle], range: NSRange(location: 0, length: description.length))
            descriptionLabel.attributedText = description
        } else {
            descriptionLabel.text = viewModel.getDescription()
        }
        
        if (viewModel.getDescription() != nil && viewModel.getDescription() != "") {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                if self.descriptionLabel.frame.size.height > self.descriptionContainerView.frame.size.height {
                    let difference = self.descriptionLabel.frame.size.height - self.descriptionContainerView.frame.size.height
                    self.popUpHeightContstraint.constant += difference
                    
                    if self.popUpHeightContstraint.constant > self.view.frame.height / 10 * 6 {
                        self.popUpHeightContstraint.constant = self.view.frame.height / 10 * 6
                    }
                    
                } else if (self.descriptionLabel.numberOfLines <= 2 && self.descriptionLabel.text != "") {
                    if (((self.descriptionContainerView.frame.size.height + self.descriptionLabel.frame.size.height) * 4.25) > self.popUpHeightContstraint.constant) {
                        self.popUpHeightContstraint.constant = ((self.descriptionContainerView.frame.size.height + self.descriptionLabel.frame.size.height) * 4.25)
                    }
                }
            }
        } else {
            self.popUpHeightContstraint.constant = self.view.frame.height / 10 * 3.5
        }
        
    }
    
    @IBAction private func firstButtonTapped(_ sender: Any) {
        dismiss(animated: false, completion: {
            self.delegate?.firstButtonClicked(sender, popUpViewController: self)
        })
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        self.viewModel.setInputString(input: self.inputTextField.text)
        dismiss(animated: false, completion: {
            self.delegate?.secondButtonClicked(sender, popUpViewController: self)
        })
    }
}

extension PopUpViewViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if inputTextField.textColor == UIColor.textSecondary30 {
            inputTextField.textColor = UIColor.black
            inputTextField.text = nil
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if inputTextField.text != "" && inputTextField.textColor == .black {
            viewModel.setInputString(input: textField.text)
        } else {
            inputTextField.textColor = UIColor.lightGray
            inputTextField.text = "e_commerce_shopping_cart_coupon_dialog_textfield_placeholder".localized
        }
    }
}
