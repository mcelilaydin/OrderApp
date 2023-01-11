//
//  UIView+Extensions.swift
//  OrderApp
//
//  Created by Celil Aydın on 11.01.2023.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
}
