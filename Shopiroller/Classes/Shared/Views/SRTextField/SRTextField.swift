//
//  SRTextField.swift
//  Shopiroller
//
//  Created by Görkem Gür on 20.12.2021.
//

import UIKit

class SRTextField: BaseView {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet private weak var errorLabelContainer: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    func setup(rightViewImage: UIImage?){
        super.setup()
        
        guard let rightImage = rightViewImage else { return }
        textField.rightViewImage = rightImage
        
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
    
    func removeError(){
        textField.layer.borderWidth = 0
        textField.layer.borderColor = UIColor.clear.cgColor
        errorLabelContainer.isHidden = true
        errorLabel.text = ""
    }
    
    func setInfoLabel() {
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = 0
        errorLabel.text = ""
    }

}

