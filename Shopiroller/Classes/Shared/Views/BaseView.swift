//
//  BaseView.swift
//  shopiroller
//
//  Created by Görkem Gür on 23.09.2021.
//

import UIKit

public class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() { }
    
}
