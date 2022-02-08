//
//  PopUpViewViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import UIKit
import Kingfisher


protocol PopUpViewViewControllerDelegate {
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
    @IBOutlet private weak var buttonContainer: UIView!
    @IBOutlet private weak var button: UIButton!
    @IBOutlet private weak var popUpHeightContstraint: NSLayoutConstraint!
    @IBOutlet private weak var descriptionContainerView: UIView!
    
    var delegate: PopUpViewViewControllerDelegate?
    
    public init(viewModel: PopUpViewModel) {
        super.init(viewModel: viewModel, nibName: PopUpViewViewController.nibName, bundle: Bundle(for: PopUpViewViewController.self))
    }
    
    override func setup() {
        super.setup()
        
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
        
        if(viewModel.hasFirstButton()) {
            firstButtonContainerView.isHidden = false
            firstButton.type = viewModel.getFirstButtonType()
            firstButton.setTitle(viewModel.getFirstButtonTitle())
            firstButton.titleLabel?.font = .semiBold14
            popUpHeightContstraint.constant += (firstButtonContainerView.frame.height)
        }else {
            firstButtonContainerView.isHidden = true
        }
        
        if(viewModel.hasSecondButton()) {
            secondButtonContainerView.isHidden = false
            secondButton.type = viewModel.getSecondButtonType()
            secondButton.setTitle(viewModel.getSecondButtonTitle())
            popUpHeightContstraint.constant += (firstButtonContainerView.frame.height * 2)
        }else {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            if self.descriptionLabel.frame.size.height > self.descriptionContainerView.frame.size.height {
                let difference = self.descriptionLabel.frame.size.height - self.descriptionContainerView.frame.size.height
                self.popUpHeightContstraint.constant += difference
                
                if self.popUpHeightContstraint.constant > self.view.frame.height / 10 * 6 {
                    self.popUpHeightContstraint.constant = self.view.frame.height / 10 * 6
                }
            }
        }
    }
  
    @IBAction private func firstButtonTapped(_ sender: Any) {
        dismiss(animated: false, completion: {
            self.delegate?.firstButtonClicked(sender, popUpViewController: self)
        })
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: {
            self.delegate?.secondButtonClicked(sender, popUpViewController: self)
        })
    }
    
}
