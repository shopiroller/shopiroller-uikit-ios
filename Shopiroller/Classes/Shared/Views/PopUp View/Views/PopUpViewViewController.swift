//
//  PopUpViewViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import UIKit
import Kingfisher

protocol BackToProductListDelegate : AnyObject {
    func popView()
    func dismissView()
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
    
    var delegate: BackToProductListDelegate?
    
    public init(viewModel: PopUpViewModel) {
        super.init(viewModel: viewModel, nibName: PopUpViewViewController.nibName, bundle: Bundle(for: PopUpViewViewController.self))
    }
    
    override func setup() {
        super.setup()
        
        containerView.makeCardView()
        
        titleLabel.text = viewModel.title
        
        descriptionLabel.text = viewModel.description
        descriptionLabel.clipsToBounds = true
        
        circleImageBackground.backgroundColor = .white
        circleImageBackground.layer.cornerRadius = circleImageBackground.frame.width / 2
        circleImage.layer.backgroundColor = UIColor.badgeSecondary.cgColor
        circleImage.layer.cornerRadius = circleImage.frame.width / 2
        circleImage.image = viewModel.image
        
        
        if let firstButton = viewModel.firstButton {
            self.firstButtonContainerView.isHidden = false
            self.firstButton.type = firstButton.buttonType
            self.firstButton.setTitle(firstButton.title)
        } else {
            self.firstButtonContainerView.isHidden = true
        }
        
        if let secondButton = viewModel.secondButton {
            self.secondButtonContainerView.isHidden = false
            self.secondButton.type = secondButton.buttonType
            self.secondButton.setTitle(secondButton.title)
        } else {
            self.secondButtonContainerView.isHidden = true
        }
    }
  
    @IBAction private func firstButtonTapped(_ sender: Any){
        
        if(viewModel.firstButton?.type == .popToRoot) {
            dismiss(animated: false, completion: nil)
            self.delegate?.popView()
        }else if viewModel.firstButton?.type == .dismiss {
            self.delegate?.dismissView()
        }
    }

}
