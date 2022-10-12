//
//  PopUpViewModel.swift
//  shopiroller
//
//  Created by Görkem Gür on 14.10.2021.
//

import Foundation
import UIKit


public class PopUpViewModel {
    
    private let image: UIImage
    private let title: String
    private let description: String?
    private let type: PopUpButtonType?
    private let htmlDescription: NSAttributedString?
    private let firstButton: PopUpButtonModel?
    private let secondButton: PopUpButtonModel?
    private var inputString: String?
    
    init(image: UIImage,
         title: String,
         description: String? = nil,
         firstButton: PopUpButtonModel? = nil,
         secondButton: PopUpButtonModel? = nil,
         htmlDescription: NSAttributedString? = nil,
         type: PopUpButtonType = .normalPopUp,
         inputString: String? = nil) {
        
        self.image = image
        self.title = title
        self.firstButton = firstButton
        self.secondButton = secondButton
        self.description = description
        self.htmlDescription = htmlDescription
        self.type = type
        self.inputString = inputString
    }
    
    func getImage() -> UIImage {
        return image
    }
    
    func getTitle() -> String {
        return title
    }
    
    func getDescription() -> String? {
        return description
    }
    
    func hasFirstButton() -> Bool {
        return firstButton != nil
    }
    
    func hasSecondButton() -> Bool {
        return secondButton != nil
    }
    
    func getFirstButtonTitle() -> String? {
        return firstButton?.title
    }
    
    func getSecondButtonTitle() -> String? {
        return secondButton?.title
    }
    
    func getFirstButtonType() -> SRButtonType? {
        return firstButton?.type
    }
    
    func getSecondButtonType() -> SRButtonType? {
        return secondButton?.type
    }
    
    func getHtmlDescription() -> NSAttributedString? {
        return htmlDescription
    }
    
    func getType() -> PopUpButtonType? {
        return type
    }
    
    func getInputString() -> String? {
        return inputString
    }
    
    func setInputString(input: String?) {
        self.inputString = input
    }
    
}

struct PopUpButtonModel {
    let title: String
    let type: SRButtonType
}

enum PopUpButtonType {
    case normalPopUp
    case inputPopUp
}
