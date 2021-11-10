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
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFromNib()
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupFromNib()
        setup()
    }
    
    func setup() { }
    
    private func nibName() -> String {
        return String(describing:type(of:self))
    }
    
    private func getNib() -> UINib {
        let bundle = Bundle(for: Self.self)
        return UINib(nibName: nibName(), bundle: bundle)
    }
    
    private func setupFromNib() {
        guard let view = getNib().instantiate(withOwner: self, options: nil).first as? UIView else { fatalError("Error loading \(self) from nib") }
        view.backgroundColor = .clear
        add(view)
    }
    
}
