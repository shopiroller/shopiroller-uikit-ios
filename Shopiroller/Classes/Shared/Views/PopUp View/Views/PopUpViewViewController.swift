//
//  PopUpViewViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import UIKit
import Kingfisher


protocol PopUpViewViewControllerDelegate {
    func firstButtonClicked(_ sender: Any)
    func secondButtonClicked(_ sender: Any)
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
        }else {
            firstButtonContainerView.isHidden = true
        }
        
        if(viewModel.hasSecondButton()) {
            secondButtonContainerView.isHidden = false
            secondButton.type = viewModel.getSecondButtonType()
            secondButton.setTitle(viewModel.getSecondButtonTitle())
        }else {
            secondButtonContainerView.isHidden = true
        }
        
        if let htmlDescription = viewModel.getHtmlDescription() {
            descriptionLabel.attributedText = htmlDescription
        } else {
            descriptionLabel.text = viewModel.getDescription()
        }
    }
  
    @IBAction private func firstButtonTapped(_ sender: Any) {
        delegate?.firstButtonClicked(sender)
        dismiss(animated: false, completion: nil)
    }
    
    @IBAction func secondButtonTapped(_ sender: Any) {
        delegate?.secondButtonClicked(sender)
        dismiss(animated: true, completion: nil)
    }
    
}
