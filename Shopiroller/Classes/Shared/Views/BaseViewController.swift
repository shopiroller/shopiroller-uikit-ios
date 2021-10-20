//
//  BaseViewController.swift
//  shopiroller
//
//  Created by Görkem Gür on 20.09.2021.
//

import Foundation
import UIKit

public class BaseViewController: UIViewController {
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        overrideUserInterfaceStyle = .light
        
    }
    
    public func setup() {
        
    }
    
    public func viewHeight() -> CGFloat {
        return self.view.frame.height
    }
}
