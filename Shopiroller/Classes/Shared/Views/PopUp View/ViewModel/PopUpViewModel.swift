//
//  PopUpViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import Foundation
import UIKit


public class PopUpViewModel {
    
    public var image: UIImage?
    public var title: String?
    public var description: String?
    public var firstButton: popUpButton?
    public var secondButton: popUpButton?
    
    public init(image: UIImage? = nil , title: String? = nil, description: String? = nil, firstButton: popUpButton? = nil , secondButton: popUpButton? = nil ){
        self.image = image
        self.title = title
        self.firstButton = firstButton
        self.secondButton = secondButton
        self.description = description
    }
}

public class popUpButton {
    public var title: String?
    public var type: popUpButtonType?
    public var viewController: UIViewController?
    public var buttonType: SRButtonType?
    
    init(title: String? = nil , type: popUpButtonType? = nil , viewController: UIViewController? = nil , buttonType: SRButtonType? = nil){
        self.title = title
        self.type = type
        self.viewController = viewController
        self.buttonType = buttonType
    }
}

public enum popUpButtonType {
    case pop
    case viewController
    case dismiss
}
