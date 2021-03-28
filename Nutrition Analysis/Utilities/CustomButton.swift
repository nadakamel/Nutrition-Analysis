//
//  CustomButton.swift
//  Nutrition Analysis
//
//  Created by Nada Kamel on 24/03/2021.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
    
    @IBInspectable var borderColor: UIColor? = UIColor.clear {
        didSet {
            layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
        }
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
    }
    
    override var isEnabled: Bool {
        didSet {
            if isEnabled {
                self.backgroundColor = .white
                self.setTitleColor(.systemGreen, for: .normal)
                self.borderColor = .systemGreen
            } else {
                self.backgroundColor = .lightGray
                self.setTitleColor(.white, for: .normal)
                self.borderColor = .lightGray
            }
        }
    }
    
}
