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
    private let htmlDescription: NSAttributedString?
    private let firstButton: PopUpButtonModel?
    private let secondButton: PopUpButtonModel?
    
    init(image: UIImage, title: String, description: String?, firstButton: PopUpButtonModel? = nil , secondButton: PopUpButtonModel? = nil, htmlDescription: NSAttributedString? = nil ){
        self.image = image
        self.title = title
        self.firstButton = firstButton
        self.secondButton = secondButton
        self.description = description
        self.htmlDescription = htmlDescription
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
    
}

struct PopUpButtonModel {
    let title: String
    let type: SRButtonType
}
