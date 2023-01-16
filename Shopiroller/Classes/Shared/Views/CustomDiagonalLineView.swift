//
//  CustomDiagonalLineView.swift
//  Shopiroller
//
//  Created by Görkem Gür on 12.01.2023.
//

import Foundation


class CustomDiagonalLineView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))

        path .move(to: CGPoint(x: 0, y: frame.height))

        UIColor.lightGray.setStroke()
        path.stroke()
        
        
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.masksToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
