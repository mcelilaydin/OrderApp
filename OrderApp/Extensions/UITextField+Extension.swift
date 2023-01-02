//
//  UITextField+Extension.swift
//  OrderApp
//
//  Created by Celil Aydın on 2.01.2023.
//

import UIKit

extension UITextField {
    
    func attributeTextField(Str : String) {
        self.layer.cornerRadius = 25
        self.layer.masksToBounds = true
        self.layer.borderColor = UIColor( #colorLiteral(red: 0.5308457613, green: 0.5860437155, blue: 0.6959124207, alpha: 0.7)).cgColor
        self.layer.borderWidth = 1.5
        self.textColor = .Gray
        self.backgroundColor = UIColor .clear
        self.font = UIFont.boldSystemFont(ofSize: 12)
        
        let placeHolderAttribute = NSAttributedString(string: Str,
                                                      attributes: [NSAttributedString.Key.foregroundColor: UIColor( #colorLiteral(red: 0.5308457613, green: 0.5860437155, blue: 0.6959124207, alpha: 0.7) ),
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12)])
        self.attributedPlaceholder = placeHolderAttribute
    }
    
    func leftPadding(_ amount:CGFloat) {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
        }
    
    func textFieldEyeButton(eyeImage: String) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: eyeImage), for: .normal)
        if eyeImage == "eye-invisible" {
            button.imageEdgeInsets = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 20)
        }else{
            button.imageEdgeInsets = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 20)
        }
        button.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(5), height: CGFloat(5))
        button.addTarget(self, action: #selector(self.updateSecureText), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    
    @objc func updateSecureText() {
        if self.isSecureTextEntry == false {
            self.isSecureTextEntry = true
            textFieldEyeButton(eyeImage: "eye.png")
        }else {
            self.isSecureTextEntry = false
            textFieldEyeButton(eyeImage: "eye-invisible")
        }
    }
}

