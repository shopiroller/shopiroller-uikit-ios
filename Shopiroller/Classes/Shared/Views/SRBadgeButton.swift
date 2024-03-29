//
//  SRBadgeButton.swift
//  Shopiroller
//
//  Created by Görkem Gür on 30.11.2021.
//

import Foundation
import UIKit

class SRBadgeButton: UIButton {
    
    private var badgeLabel = UILabel()
    
    var badgeCount: String? {
        didSet {
            addBadgeCount(badgeCount: badgeCount)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addBadgeCount(badgeCount: badgeCount)
    }
    
    func addBadgeCount(badgeCount: String?) {
        badgeLabel.layer.cornerRadius = badgeLabel.bounds.size.height / 2
        badgeLabel.textAlignment = .center
        badgeLabel.textColor = .white
        badgeLabel.sizeToFit()
        badgeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        badgeLabel.backgroundColor = UIColor(red: 221/255, green: 55/255, blue: 95/255, alpha: 1)
        let badgeSize = badgeLabel.frame.size
        self.badgeLabel.text = badgeCount
        
        let height = max(15, Double(badgeSize.height) + 2.0)
        let width = max(height, Double(badgeSize.width) + 5.0)
        
        var vertical: Double?, horizontal: Double?
        
        let badgeInset = UIEdgeInsets(top: 4, left: 20, bottom: 0, right: 0)
        
        vertical = Double(badgeInset.top) - Double(badgeInset.bottom)
        horizontal = Double(badgeInset.left) - Double(badgeInset.right)
        
        let x = (Double(bounds.size.width) - 5 + horizontal!)
        let y = -(Double(bounds.height) / 2) - 5 + vertical!
        badgeLabel.frame = CGRect(x: x, y: y, width: width, height: height)
   
        
        badgeLabel.frame = CGRect(x: x, y: y, width: CGFloat(width), height: CGFloat(height))
            
        badgeLabel.layer.cornerRadius = badgeLabel.frame.height/2
        badgeLabel.layer.masksToBounds = true
        if (badgeCount == "0" || badgeCount == nil) {
            badgeLabel.isHidden = true
        } else {
            badgeLabel.isHidden = false
        }
        addSubview(badgeLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addBadgeCount(badgeCount: nil)
        fatalError("init(coder:) has not been implemented")
    }
}
