//
//  SRTextField.swift
//  Shopiroller
//
//  Created by Görkem Gür on 20.12.2021.
//

import UIKit

class SRTextField: SRBaseView {

    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var errorLabelContainer: UIView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private var type: SRTextFieldType?
    
    func setup(rightViewImage: UIImage? , type: SRTextFieldType){
        super.setup()
        guard let rightImage = rightViewImage else { return }
        self.type = type
        textField.rightViewImage(image: rightImage, type: type)
    }
    
    func getTextField() -> UITextField {
        return textField
    }
    
    func getErrorLabelText() -> String? {
        return errorLabel.text ?? ""
    }
    
    var isEnabled: Bool = true {
        didSet {
            setTextFieldSituation()
        }
    }
    
    func setError(errorMessage: String?) {
        errorLabelContainer.isHidden = false
        let color = CABasicAnimation(keyPath: "borderColor")
        color.fromValue = UIColor.black.cgColor
        color.toValue = UIColor.red.cgColor
        color.duration = 3
        color.repeatCount = 1
        self.textField.layer.borderWidth = 1
        self.textField.layer.cornerRadius = 6
        self.textField.layer.borderColor = UIColor.red.cgColor
        self.textField.layer.add(color, forKey: "borderColor")
        errorLabel.backgroundColor = .clear
        errorLabel.numberOfLines = 2
        errorLabel.text = errorMessage
        errorLabel.textColor = .red
        errorLabel.textAlignment = .left
        errorLabel.font = UIFont.systemFont(ofSize: 9)
    }
    
    func removeError() {
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.clear.cgColor
        errorLabelContainer.isHidden = true
        errorLabel.text = ""
    }
    
    func setInfoLabel(infoText: String?) {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
        errorLabel.text = infoText
    }
    
    private func setTextFieldSituation() {
        textField.isEnabled = isEnabled
        if isEnabled {
            textField.textColor = .textPrimary
        } else {
            if (type == .withNoPadding) {
                textField.textColor = .textPrimary
                textField.font = .semiBold14
            } else if (type == .withPadding) {
                textField.textColor = .textPCaption
            } else {
                textField.borderStyle = .none
                textField.isUserInteractionEnabled = false
            }
        }
    }

}

enum SRTextFieldType {
    case withPadding,withNoPadding,emptyTextField
}

