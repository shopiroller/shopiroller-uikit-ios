//
//  PopUpViewViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import UIKit
import Kingfisher

extension PopUpViewViewController : NibLoadable { }

class PopUpViewViewController: BaseViewController {

    
    @IBOutlet private weak var circleImageBackground: UIView!
    @IBOutlet private weak var circleImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var firstButton: SRButton!
    @IBOutlet private weak var secondButton: SRButton!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var firstButtonContainerView: UIView!
    @IBOutlet private weak var secondButtonContainerView: UIView!

    private let viewModel : PopUpViewModel
    
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
    
    public init(viewModel: PopUpViewModel = PopUpViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: PopUpViewViewController.nibName, bundle: Bundle(for: PopUpViewViewController.self))
    }
    
    
    public required init?(coder aDecoder: NSCoder) {
        self.viewModel = PopUpViewModel()
        super.init(coder: aDecoder)
    }
    
    
    @IBAction private func firstButtonTapped(_ sender: Any){
        if(viewModel.secondButton?.type == .viewController) {
            if let viewController = viewModel.secondButton?.viewController {
                pop(animated: false) {
                    self.prompt(viewController, animated: true)
                }
            }
        }else{
            pop(animated: true, completion: nil)
        }
    }



}
